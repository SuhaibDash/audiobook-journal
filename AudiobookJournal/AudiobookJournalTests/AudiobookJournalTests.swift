//
//  AudiobookJournalTests.swift
//  AudiobookJournalTests
//
//  Created by Suhaib Dashash on 9/13/26.
//

import Foundation
import SwiftData
import Testing
@testable import AudiobookJournal

private enum TestRepositoryError: LocalizedError {
    case saveFailed

    var errorDescription: String? {
        "The test repository refused to save."
    }
}

@MainActor
private final class FailingLibraryRepository: LibraryRepository {
    private(set) var bookSaveCallCount = 0
    private(set) var entrySaveCallCount = 0
    private let snapshot: LibrarySnapshot

    init(snapshot: LibrarySnapshot = .empty) {
        self.snapshot = snapshot
    }

    func fetchLibrary() throws -> LibrarySnapshot {
        snapshot
    }

    func save(book: Book) throws {
        bookSaveCallCount += 1
        throw TestRepositoryError.saveFailed
    }

    func save(entry: Entry) throws {
        entrySaveCallCount += 1
        throw TestRepositoryError.saveFailed
    }
}

struct AudiobookJournalTests {

    @Test
    @MainActor
    func entriesUseCaptureOrderAndExcludeOtherBooks() {
        let book = Book(title: "Dune", author: "Frank Herbert")
        let otherBook = Book(title: "Other book", author: "Another author")
        let oldest = Entry(
            bookId: book.id, type: .note, chapterNumber: 10, body: "First",
            createdAt: Date(timeIntervalSince1970: 100),
            updatedAt: Date(timeIntervalSince1970: 400)
        )
        let general = Entry(
            bookId: book.id, type: .reflection, body: "Second",
            createdAt: Date(timeIntervalSince1970: 200)
        )
        let newest = Entry(
            bookId: book.id, type: .note, chapterNumber: 3, body: "Third",
            createdAt: Date(timeIntervalSince1970: 300)
        )
        let unrelated = Entry(
            bookId: otherBook.id, type: .note, body: "Other book's note",
            createdAt: Date(timeIntervalSince1970: 50)
        )
        let repository = FailingLibraryRepository(snapshot: LibrarySnapshot(
            books: [book, otherBook],
            entries: [newest, unrelated, oldest, general]
        ))
        let viewModel = LibraryViewModel(repository: repository)

        #expect(viewModel.entries(for: book).map(\.id) == [
            oldest.id, general.id, newest.id
        ])
    }

    @Test
    @MainActor
    func failedStoredWritesRollBackAndCanBeRetried() throws {
        let container = try ModelContainer(
            for: StoredBook.self, StoredEntry.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        var shouldFail = false
        let repository = SwiftDataLibraryRepository(modelContainer: container) { context in
            #expect(context !== container.mainContext)
            #expect(!context.autosaveEnabled)
            if shouldFail {
                throw TestRepositoryError.saveFailed
            }
            try context.save()
        }
        let book = Book(title: "Dune", author: "Frank Herbert")
        try repository.save(book: book)

        // Pending changes in another context must survive our rollback.
        container.mainContext.autosaveEnabled = false
        let unrelatedBook = StoredBook(domainBook: Book(title: "Other draft", author: "Author"))
        container.mainContext.insert(unrelatedBook)

        shouldFail = true
        var editedBook = book
        editedBook.title = "Unsaved title"
        #expect(throws: TestRepositoryError.self) {
            try repository.save(book: editedBook)
        }
        #expect(try repository.fetchLibrary().books.first?.title == "Dune")
        #expect(container.mainContext.insertedModelsArray.contains { $0 === unrelatedBook })

        let newBook = Book(title: "Retry me", author: "Author")
        #expect(throws: TestRepositoryError.self) {
            try repository.save(book: newBook)
        }
        #expect(try repository.fetchLibrary().books.count == 1)

        let entry = Entry(bookId: book.id, type: .note, body: "Keep this draft")
        #expect(throws: TestRepositoryError.self) {
            try repository.save(entry: entry)
        }
        #expect(try repository.fetchLibrary().entries.isEmpty)

        shouldFail = false
        try repository.save(entry: entry)
        try repository.save(book: newBook)

        shouldFail = true
        var editedEntry = entry
        editedEntry.body = "Unsaved edit"
        #expect(throws: TestRepositoryError.self) {
            try repository.save(entry: editedEntry)
        }
        #expect(try repository.fetchLibrary().entries.first?.body == entry.body)

        // A subsequent successful save must not persist the failed edits.
        shouldFail = false
        try repository.save(book: newBook)
        let reader = SwiftDataLibraryRepository(modelContainer: container)
        let snapshot = try reader.fetchLibrary()
        #expect(snapshot.books.count == 2)
        #expect(snapshot.books.first { $0.id == book.id }?.title == "Dune")
        #expect(snapshot.entries.count == 1)
        #expect(snapshot.entries.first?.body == entry.body)
        container.mainContext.rollback()
    }

    @Test
    @MainActor
    func addBookReportsFailureWithoutChangingBooks() {
        let repository = FailingLibraryRepository()
        let viewModel = LibraryViewModel(repository: repository)

        let result = viewModel.addBook(
            title: "Dune",
            author: "Frank Herbert",
            seriesName: "Dune",
            seriesOrder: 1,
            status: .wantToRead
        )

        guard case .failure(let message) = result else {
            Issue.record("Expected the book save to fail.")
            return
        }

        #expect(message == "The test repository refused to save.")
        #expect(viewModel.errorMessage == message)
        #expect(viewModel.books.isEmpty)
    }

    @Test
    @MainActor
    func addEntryReportsFailureWithoutChangingEntries() {
        let repository = FailingLibraryRepository()
        let viewModel = LibraryViewModel(repository: repository)
        let book = Book(
            title: "Dune",
            author: "Frank Herbert"
        )

        let result = viewModel.addEntry(
            to: book,
            type: .note,
            chapterNumber: 1,
            body: "An important introduction."
        )

        guard case .failure(let message) = result else {
            Issue.record("Expected the entry save to fail.")
            return
        }

        #expect(message == "The test repository refused to save.")
        #expect(viewModel.errorMessage == message)
        #expect(viewModel.entries(for: book).isEmpty)
    }

    @Test(arguments: [0, -1])
    @MainActor
    func invalidChapterNeverReachesRepository(chapterNumber: Int) {
        let repository = FailingLibraryRepository()
        let viewModel = LibraryViewModel(repository: repository)
        let book = Book(title: "Dune", author: "Frank Herbert")

        let result = viewModel.addEntry(
            to: book,
            type: .note,
            chapterNumber: chapterNumber,
            body: "An important detail."
        )

        guard case .failure(let message) = result else {
            Issue.record("Expected invalid chapter to be rejected.")
            return
        }

        #expect(message == "Chapter must be a positive whole number.")
        #expect(repository.entrySaveCallCount == 0)
        #expect(viewModel.entries(for: book).isEmpty)
    }

    @Test(arguments: [0, -1])
    @MainActor
    func invalidSeriesOrderNeverReachesRepository(seriesOrder: Int) {
        let repository = FailingLibraryRepository()
        let viewModel = LibraryViewModel(repository: repository)

        let result = viewModel.addBook(
            title: "Dune",
            author: "Frank Herbert",
            seriesName: "Dune",
            seriesOrder: seriesOrder,
            status: .wantToRead
        )

        guard case .failure(let message) = result else {
            Issue.record("Expected invalid series order to be rejected.")
            return
        }

        #expect(message == "Series order must be a positive whole number.")
        #expect(repository.bookSaveCallCount == 0)
        #expect(viewModel.books.isEmpty)
    }

    @Test(arguments: [nil, 1, 12] as [Int?])
    @MainActor
    func validSeriesOrderReachesRepository(seriesOrder: Int?) {
        let repository = FailingLibraryRepository()
        let viewModel = LibraryViewModel(repository: repository)

        let result = viewModel.addBook(
            title: "Dune",
            author: "Frank Herbert",
            seriesName: "Dune",
            seriesOrder: seriesOrder,
            status: .wantToRead
        )

        #expect(repository.bookSaveCallCount == 1)

        guard case .failure(let message) = result else {
            Issue.record("Expected the test repository to fail.")
            return
        }

        #expect(message == "The test repository refused to save.")
    }

    @Test(arguments: [nil, 1, 12] as [Int?])
    @MainActor
    func validChapterReachesRepository(chapterNumber: Int?) {
        let repository = FailingLibraryRepository()
        let viewModel = LibraryViewModel(repository: repository)
        let book = Book(title: "Dune", author: "Frank Herbert")

        let result = viewModel.addEntry(
            to: book,
            type: .note,
            chapterNumber: chapterNumber,
            body: "An important detail."
        )

        #expect(repository.entrySaveCallCount == 1)

        guard case .failure(let message) = result else {
            Issue.record("Expected the test repository to fail.")
            return
        }

        #expect(message == "The test repository refused to save.")
    }
}
