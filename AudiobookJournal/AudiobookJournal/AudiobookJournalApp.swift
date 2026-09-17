 //
//  AudiobookJournalApp.swift
//  AudiobookJournal
//
//  Created by Suhaib Dashash on 9/13/26.
//

import SwiftUI
import SwiftData

@main
@MainActor
struct AudiobookJournalApp: App {
    private let modelContainer: ModelContainer
    private let libraryViewModel: LibraryViewModel

    init() {
        do {
            let modelContainer = try ModelContainer(
                for: StoredBook.self,
                StoredEntry.self
            )

            self.modelContainer = modelContainer

            let repository = SwiftDataLibraryRepository(
                modelContext: modelContainer.mainContext
            )

            libraryViewModel = LibraryViewModel(
                repository: repository
            )
        } catch {
            fatalError(
                "Unable to create SwiftData storage: \(error.localizedDescription)"
            )
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: libraryViewModel)
        }
        .modelContainer(modelContainer)
    }
}
