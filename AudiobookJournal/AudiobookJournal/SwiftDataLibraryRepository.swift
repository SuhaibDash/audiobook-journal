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

    func save(book: Book) throws {
        if let existingBook = try storedBook(id: book.id) {
            existingBook.update(from: book)
        } else {
            let newStoredBook = StoredBook(domainBook: book)
            modelContext.insert(newStoredBook)
        }

        try modelContext.save()
    }

    private func storedBook(id: UUID) throws -> StoredBook? {
        let targetId = id

        var descriptor = FetchDescriptor<StoredBook>(
            predicate: #Predicate<StoredBook> { storedBook in
                storedBook.id == targetId
            }
        )
        descriptor.fetchLimit = 1

        return try modelContext.fetch(descriptor).first
    }

    private func storedEntry(id: UUID) throws -> StoredEntry? {
        let targetId = id

        var descriptor = FetchDescriptor<StoredEntry>(
            predicate: #Predicate<StoredEntry> { storedEntry in
                storedEntry.id == targetId
            }
        )
        descriptor.fetchLimit = 1

        return try modelContext.fetch(descriptor).first
    }
}
