//
//  EntryComposerView.swift
//  AudiobookJournal
//
//  Created by Suhaib Dashash on 9/14/26.
//

import SwiftUI

struct EntryComposerView: View {
    let onSave: (EntryType, Int?, String) -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var entryType: EntryType = .note
    @State private var chapterText = ""
    @State private var bodyText = ""

    private var trimmedBody: String {
        bodyText.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Thought") {
                    Picker("Type", selection: $entryType) {
                        ForEach(EntryType.allCases, id: \.rawValue) { type in
                            Text(type.displayName)
                                .tag(type)
                        }
                    }

                    TextField("Chapter (optional)", text: $chapterText)
                        .keyboardType(.numberPad)
                }

                Section("Entry") {
                    TextEditor(text: $bodyText)
                        .frame(minHeight: 160)
                }
            }
            .navigationTitle("Add Thought")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(entryType, Int(chapterText), trimmedBody)
                        dismiss()
                    }
                    .disabled(trimmedBody.isEmpty)
                }
            }
        }
    }
}
