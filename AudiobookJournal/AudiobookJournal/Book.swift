//
//  Book.swift
//  AudiobookJournal
//
//  Created by Suhaib Dashash on 9/13/26.
//

import Foundation

enum ReadingStatus: String, CaseIterable {
    case wantToRead
    case currentlyListening
    case finished

    var displayName: String {
        switch self {
        case .wantToRead:
            "Wishlist"
        case .currentlyListening:
            "Currently Listening"
        case .finished:
            "Finished"
        }
    }
}

struct Book: Identifiable {
    let id: UUID
    var title: String
    var author: String
    var seriesName: String?
    var seriesOrder: Int?
    var status: ReadingStatus
    let createdAt: Date
    var updatedAt: Date

    init(
        title: String,
        author: String,
        seriesName: String? = nil,
        seriesOrder: Int? = nil,
        status: ReadingStatus = .wantToRead,
        id: UUID = UUID(),
        createdAt: Date = Date(),
        updatedAt: Date? = nil
    ) {
        self.id = id
        self.title = title
        self.author = author
        self.seriesName = seriesName
        self.seriesOrder = seriesOrder
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt ?? createdAt
    }
}
