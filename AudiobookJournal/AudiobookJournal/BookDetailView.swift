//
//  BookDetailView.swift
//  AudiobookJournal
//
//  Created by Suhaib Dashash on 9/13/26.
//

import SwiftUI

struct BookDetailView: View {
    let book: Book

    var body: some View {
        List {
            Section("Book") {
                LabeledContent("Author", value: book.author)

                if let seriesName = book.seriesName {
                    LabeledContent("Series", value: seriesName)
                }

                if let seriesOrder = book.seriesOrder {
                    LabeledContent("Series Order", value: "#\(seriesOrder)")
                }
            }

            Section("Thoughts") {
                Text("No thoughts yet.")
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
