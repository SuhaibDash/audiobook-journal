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
    private(set) var books: [Book]
    private var entries: [Entry]
    private(set) var errorMessage: String?

    init() {
        let wayOfKings = Book(
            title: "The Way of Kings",
            author: "Brandon Sanderson",
            seriesName: "The Stormlight Archive",
            seriesOrder: 1,
            status: .finished
        )

        let wordsOfRadiance = Book(
            title: "Words of Radiance",
            author: "Brandon Sanderson",
            seriesName: "The Stormlight Archive",
            seriesOrder: 2,
            status: .currentlyListening
        )

        let oathbringer = Book(
            title: "Oathbringer",
            author: "Brandon Sanderson",
            seriesName: "The Stormlight Archive",
            seriesOrder: 3,
            status: .wantToRead
        )

        books = [wayOfKings, wordsOfRadiance, oathbringer]

        entries = [
            Entry(
                bookId: wordsOfRadiance.id,
                type: .note,
                chapterNumber: 10,
                body: "The oathgate is more important than I first thought."
            ),
            Entry(
                bookId: wordsOfRadiance.id,
                type: .prediction,
                chapterNumber: 24,
                body: "I think Kaladin will return to the Shattered Plains."
            )
        ]
    }

    init(repository: any LibraryRepository) {
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
