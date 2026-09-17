//
//  LibraryViewModel.swift
//  AudiobookJournal
//
//  Created by Suhaib Dashash on 9/13/26.
//

import Observation

@MainActor
@Observable
final class LibraryViewModel {
    private let repository: any LibraryRepository

    private(set) var books: [Book]
    private var entries: [Entry]
    private(set) var errorMessage: String?

    init(repository: any LibraryRepository) {
        self.repository = repository
        do {
            let snapshot = try repository.fetchLibrary()
            books = snapshot.books
            entries = snapshot.entries
        } catch {
            books = []
            entries = []
            errorMessage = error.localizedDescription
        }
    }

    func entries(for book: Book) -> [Entry] {
        entries.filter { $0.bookId == book.id }
    }

    func addEntry(
        to book: Book,
        type: EntryType,
        chapterNumber: Int?,
        body: String
    ) {
        let entry = Entry(
            bookId: book.id,
            type: type,
            chapterNumber: chapterNumber,
            body: body
        )

        entries.append(entry)
    }

    func addBook(
        title: String,
        author: String,
        seriesName: String?,
        seriesOrder: Int?,
        status: ReadingStatus
    ) {
        let book = Book(
            title: title,
            author: author,
            seriesName: seriesName,
            seriesOrder: seriesOrder,
            status: status
        )

        books.append(book)
    }
}
