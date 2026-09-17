//
//  StoredModelMapping.swift
//  AudiobookJournal
//
//  Created by Suhaib Dashash on 9/15/26.
//

import Foundation

extension StoredBook {
    convenience init(domainBook: Book) {
        self.init(
            id: domainBook.id,
            title: domainBook.title,
            author: domainBook.author,
            seriesName: domainBook.seriesName,
            seriesOrder: domainBook.seriesOrder,
            statusRawValue: domainBook.status.rawValue,
            createdAt: domainBook.createdAt,
            updatedAt: domainBook.updatedAt
        )
    }

    func update(from domainBook: Book) {
        title = domainBook.title
        author = domainBook.author
        seriesName = domainBook.seriesName
        seriesOrder = domainBook.seriesOrder
        statusRawValue = domainBook.status.rawValue
        createdAt = domainBook.createdAt
        updatedAt = domainBook.updatedAt
    }

    func domainBook() throws -> Book {
        guard let status = ReadingStatus(rawValue: statusRawValue) else {
            throw LibraryRepositoryError.invalidReadingStatus(statusRawValue)
        }

        return Book(
            title: title,
            author: author,
            seriesName: seriesName,
            seriesOrder: seriesOrder,
            status: status,
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
}

extension StoredEntry {
    convenience init(
        domainEntry: Entry,
        storedBook: StoredBook
    ) {
        self.init(
            id: domainEntry.id,
            typeRawValue: domainEntry.type.rawValue,
            chapterNumber: domainEntry.chapterNumber,
            body: domainEntry.body,
            createdAt: domainEntry.createdAt,
            updatedAt: domainEntry.updatedAt,
            book: storedBook
        )
    }

    func update(
        from domainEntry: Entry,
        storedBook: StoredBook
    ) {
        typeRawValue = domainEntry.type.rawValue
        chapterNumber = domainEntry.chapterNumber
        body = domainEntry.body
        createdAt = domainEntry.createdAt
        updatedAt = domainEntry.updatedAt
        book = storedBook
    }

    func domainEntry() throws -> Entry {
        guard let type = EntryType(rawValue: typeRawValue) else {
            throw LibraryRepositoryError.invalidEntryType(typeRawValue)
        }

        return Entry(
            bookId: book.id,
            type: type,
            chapterNumber: chapterNumber,
            body: body,
            id: id,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
}
