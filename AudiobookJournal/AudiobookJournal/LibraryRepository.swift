//
//  LibraryRepository.swift
//  AudiobookJournal
//
//  Created by Suhaib Dashash on 9/15/26.
//

import Foundation

struct LibrarySnapshot {
    let books: [Book]
    let entries: [Entry]

    static let empty = LibrarySnapshot(
        books: [],
        entries: []
    )
}

@MainActor
protocol LibraryRepository {
    func fetchLibrary() throws -> LibrarySnapshot
    func save(book: Book) throws
    func save(entry: Entry) throws
}

enum LibraryRepositoryError: LocalizedError {
    case invalidReadingStatus(String)
    case invalidEntryType(String)
    case missingBook(UUID)

    var errorDescription: String? {
        switch self {
        case .invalidReadingStatus(let rawValue):
            "Stored reading status is invalid: \(rawValue)"

        case .invalidEntryType(let rawValue):
            "Stored entry type is invalid: \(rawValue)"

        case .missingBook(let bookId):
            "No stored book exists for entry book ID \(bookId)."
        }
    }
}
