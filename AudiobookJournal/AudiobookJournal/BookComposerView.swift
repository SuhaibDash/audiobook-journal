//
//  BookComposerView.swift
//  AudiobookJournal
//
//  Created by Suhaib Dashash on 9/15/26.
//

import SwiftUI

struct BookComposerView: View {
    let onSave: (String, String, String?, Int?, ReadingStatus) -> Bool

    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var author = ""
    @State private var seriesName = ""
    @State private var seriesOrderText = ""
    @State private var status: ReadingStatus = .wantToRead

    private var trimmedTitle: String {
        title.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var trimmedAuthor: String {
        author.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var optionalSeriesName: String? {
        let trimmedName = seriesName.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedName.isEmpty ? nil : trimmedName
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Book") {
                    TextField("Title", text: $title)
                    TextField("Author", text: $author)

                    Picker("Status", selection: $status) {
                        ForEach(ReadingStatus.allCases, id: \.rawValue) { status in
                            Text(status.displayName)
                                .tag(status)
                        }
                    }
                }

                Section("Series") {
                    TextField("Series name (optional)", text: $seriesName)

                    TextField("Series order (optional)", text: $seriesOrderText)
                        .keyboardType(.numberPad)
                }
            }
            .navigationTitle("Add Book")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let didSave = onSave(
                            trimmedTitle,
                            trimmedAuthor,
                            optionalSeriesName,
                            Int(seriesOrderText),
                            status
                        )

                        if didSave {
                            dismiss()
                        }
                    }
                    .disabled(trimmedTitle.isEmpty || trimmedAuthor.isEmpty)
                }
            }
        }
    }
}
