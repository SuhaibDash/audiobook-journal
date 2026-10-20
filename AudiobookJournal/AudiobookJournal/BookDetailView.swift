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
    @State private var isPresentingEntryComposer = false
    @State private var statusErrorMessage = ""
    @State private var isShowingStatusError = false

    private var readingStatus: Binding<ReadingStatus> {
        Binding(
            get: {
                libraryViewModel.books.first { $0.id == book.id }?.status
                    ?? book.status
            },
            set: { newStatus in
                let result = libraryViewModel.changeReadingStatus(
                    for: book.id,
                    to: newStatus
                )
                if case .failure(let message) = result {
                    statusErrorMessage = message
                    isShowingStatusError = true
                }
            }
        )
    }

    var body: some View {
        let entries = libraryViewModel.entries(for: book)
        List {
            Section("Book") {
                LabeledContent("Author", value: book.author)

                Picker("Reading status", selection: readingStatus) {
                    ForEach(ReadingStatus.allCases, id: \.rawValue) { status in
                        Text(status.displayName)
                            .tag(status)
                    }
                }

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
        .alert("Couldn't Change Status", isPresented: $isShowingStatusError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(statusErrorMessage)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isPresentingEntryComposer = true
                } label: {
                    Label("Add Thought", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $isPresentingEntryComposer) {
            EntryComposerView { type, chapterNumber, body in
                libraryViewModel.addEntry(
                    to: book,
                    type: type,
                    chapterNumber: chapterNumber,
                    body: body
                )
            }
        }
    }
}
