//
//  BookDetailView.swift
//  AudiobookJournal
//
//  Created by Suhaib Dashash on 9/13/26.
//

import SwiftUI

struct BookDetailView: View {
    let book: Book
    let libraryViewModel: LibraryViewModel

    var body: some View {
        let entries = libraryViewModel.entries(for: book)
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
                if entries.isEmpty {
                    Text("No thoughts yet.")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(entries) { entry in
                        VStack(alignment: .leading, spacing: 6) {
                            HStack(spacing: 8) {
                                Text(entry.type.displayName)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)

                                if let chapterNumber = entry.chapterNumber {
                                    Text("Chapter \(chapterNumber)")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }

                            Text(entry.body)
                        }
                    }
                }
            }
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
