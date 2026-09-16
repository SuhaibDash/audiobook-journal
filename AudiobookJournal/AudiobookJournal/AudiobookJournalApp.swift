 //
//  AudiobookJournalApp.swift
//  AudiobookJournal
//
//  Created by Suhaib Dashash on 9/13/26.
//

import SwiftUI
import SwiftData

@main
struct AudiobookJournalApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [
            StoredBook.self,
            StoredEntry.self
        ])
    }
}
