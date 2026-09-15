//
//  Entry.swift
//  AudiobookJournal
//
//  Created by Suhaib Dashash on 9/14/26.
//

import Foundation

enum EntryType: String, CaseIterable {
    case note
    case reflection
    case prediction

    var displayName: String {
        switch self {
        case .note:
            "Note"
        case .reflection:
            "Reflection"
        case .prediction:
            "Prediction"
        }
    }
}

struct Entry: Identifiable {
    let id: UUID
    let bookId: UUID
    var type: EntryType
    var chapterNumber: Int?
    var body: String
    let createdAt: Date
    var updatedAt: Date
    
    init(
        bookId: UUID,
        type: EntryType,
        chapterNumber: Int? = nil,
        body: String,
        id: UUID = UUID(),
        createdAt: Date = Date(),
        updatedAt: Date? = nil
    ) {
        self.id = id
        self.bookId = bookId
        self.type = type
        self.chapterNumber = chapterNumber
        self.body = body
        self.createdAt = createdAt
        self.updatedAt = updatedAt ?? createdAt
    }
}
