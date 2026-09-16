//
//  StoredModels.swift
//  AudiobookJournal
//
//  Created by Suhaib Dashash on 9/15/26.
//

import Foundation
import SwiftData

@Model
final class StoredBook {
    @Attribute(.unique) var id: UUID
    var title: String
    var author: String
    var seriesName: String?
    var seriesOrder: Int?
    var statusRawValue: String
    var createdAt: Date
    var updatedAt: Date

    @Relationship(deleteRule: .cascade, inverse: \StoredEntry.book)
    var entries: [StoredEntry] = []

    init(
        id: UUID,
        title: String,
        author: String,
        seriesName: String?,
        seriesOrder: Int?,
        statusRawValue: String,
        createdAt: Date,
        updatedAt: Date
    ) {
        self.id = id
        self.title = title
        self.author = author
        self.seriesName = seriesName
        self.seriesOrder = seriesOrder
        self.statusRawValue = statusRawValue
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

@Model
final class StoredEntry {
    @Attribute(.unique) var id: UUID
    var typeRawValue: String
    var chapterNumber: Int?
    var body: String
    var createdAt: Date
    var updatedAt: Date
    var book: StoredBook

    init(
        id: UUID,
        typeRawValue: String,
        chapterNumber: Int?,
        body: String,
        createdAt: Date,
        updatedAt: Date,
        book: StoredBook
    ) {
        self.id = id
        self.typeRawValue = typeRawValue
        self.chapterNumber = chapterNumber
        self.body = body
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.book = book
    }
}
