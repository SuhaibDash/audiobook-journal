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

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }

}
