//
//  SwiftDataLibraryRepository.swift
//  AudiobookJournal
//
//  Created by Suhaib Dashash on 9/15/26.
//

import Foundation
import SwiftData

@MainActor
final class SwiftDataLibraryRepository {
    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func fetchLibrary() throws -> LibrarySnapshot {
        let bookDescriptor = FetchDescriptor<StoredBook>(
            sortBy: [
                SortDescriptor(\StoredBook.createdAt, order: .forward)
            ]
        )

        let entryDescriptor = FetchDescriptor<StoredEntry>(
            sortBy: [
                SortDescriptor(\StoredEntry.createdAt, order: .forward)
            ]
        )

        let storedBooks = try modelContext.fetch(bookDescriptor)
        let storedEntries = try modelContext.fetch(entryDescriptor)

        let books = try storedBooks.map { storedBook in
            try storedBook.domainBook()
        }

        let entries = try storedEntries.map { storedEntry in
            try storedEntry.domainEntry()
        }

        return LibrarySnapshot(
            books: books,
            entries: entries
        )
    }
}
