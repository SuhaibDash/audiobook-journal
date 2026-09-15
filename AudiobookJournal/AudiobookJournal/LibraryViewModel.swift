//
//  LibraryViewModel.swift
//  AudiobookJournal
//
//  Created by Suhaib Dashash on 9/13/26.
//

import Observation

@Observable
final class LibraryViewModel {
    let books: [Book]
    private let entries: [Entry]

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

    func entries(for book: Book) -> [Entry] {
        entries.filter { $0.bookId == book.id }
    }
}
