//
//  LibraryViewModel.swift
//  AudiobookJournal
//
//  Created by Suhaib Dashash on 9/13/26.
//

import Observation

@Observable
final class LibraryViewModel {
    let books: [Book] = [
        Book(
            title: "The Way of Kings",
            author: "Brandon Sanderson",
            seriesName: "The Stormlight Archive",
            seriesOrder: 1,
            status: .finished
        ),
        Book(
            title: "Words of Radiance",
            author: "Brandon Sanderson",
            seriesName: "The Stormlight Archive",
            seriesOrder: 2,
            status: .currentlyListening
        )
    ]
}
