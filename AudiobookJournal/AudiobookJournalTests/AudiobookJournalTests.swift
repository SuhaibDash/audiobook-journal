//
//  AudiobookJournalTests.swift
//  AudiobookJournalTests
//
//  Created by Suhaib Dashash on 9/13/26.
//

import Foundation
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
    func fetchLibrary() throws -> LibrarySnapshot {
        .empty
    }

    func save(book: Book) throws {
        throw TestRepositoryError.saveFailed
    }

    func save(entry: Entry) throws {
        throw TestRepositoryError.saveFailed
    }
}

struct AudiobookJournalTests {

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

}
