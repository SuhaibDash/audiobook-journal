//
//  ContentView.swift
//  AudiobookJournal
//
//  Created by Suhaib Dashash on 9/13/26.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = LibraryViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(ReadingStatus.allCases, id: \.rawValue) { status in
                    Section(status.displayName) {
                        ForEach(viewModel.books.filter { $0.status == status }) { book in
                            NavigationLink {
                                BookDetailView(book: book)
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
        }
    }
}

#Preview {
    ContentView()
}
