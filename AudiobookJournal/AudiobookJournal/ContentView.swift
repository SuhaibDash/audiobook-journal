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
            List(viewModel.books) { book in
                VStack(alignment: .leading, spacing: 4) {
                    Text(book.title)
                        .font(.headline)
                    
                    Text(book.author)
                        .foregroundStyle(.secondary)
                    
                    Text(book.status.displayName)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Library")
        }
    }
}

#Preview {
    ContentView()
}
