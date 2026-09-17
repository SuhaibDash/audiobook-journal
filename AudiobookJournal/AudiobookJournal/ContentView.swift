//
//  ContentView.swift
//  AudiobookJournal
//
//  Created by Suhaib Dashash on 9/13/26.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel: LibraryViewModel
    @State private var isPresentingBookComposer = false

    @MainActor
    init(viewModel: LibraryViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    @MainActor
    init() {
        _viewModel = State(initialValue: LibraryViewModel())
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(ReadingStatus.allCases, id: \.rawValue) { status in
                    Section(status.displayName) {
                        ForEach(viewModel.books.filter { $0.status == status }) { book in
                            NavigationLink {
                                BookDetailView(
                                    book: book,
                                    libraryViewModel: viewModel
                                )
                            } label: {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(book.title)
                                        .font(.headline)

                                    Text(book.author)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Library")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isPresentingBookComposer = true
                    } label: {
                        Label("Add Book", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isPresentingBookComposer) {
                BookComposerView {
                    title,
                    author,
                    seriesName,
                    seriesOrder,
                    status in

                    viewModel.addBook(
                        title: title,
                        author: author,
                        seriesName: seriesName,
                        seriesOrder: seriesOrder,
                        status: status
                    )
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
