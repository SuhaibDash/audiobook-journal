//
//  BookComposerView.swift
//  AudiobookJournal
//
//  Created by Suhaib Dashash on 9/15/26.
//

import SwiftUI

struct BookComposerView: View {
    let onSave: (String, String, String?, Int?, ReadingStatus) -> SaveResult

    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var author = ""
    @State private var seriesName = ""
    @State private var seriesOrderText = ""
    @State private var status: ReadingStatus = .wantToRead
    @State private var saveErrorMessage = ""
    @State private var isShowingSaveError = false

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
                        let result = onSave(
                            trimmedTitle,
                            trimmedAuthor,
                            optionalSeriesName,
                            Int(seriesOrderText),
                            status
                        )

                        switch result {
                        case .success:
                            dismiss()

                        case .failure(let message):
                            saveErrorMessage = message
                            isShowingSaveError = true
                        }
                    }
                    .disabled(trimmedTitle.isEmpty || trimmedAuthor.isEmpty)
                }
            }
            .alert(
                "Couldn't save book, please try again.",
                isPresented: $isShowingSaveError
            ) {
                Button("Ok", role: .cancel) {}
            } message: {
                Text(saveErrorMessage)
            }
        }
    }
}

#Preview("Save failure") {
    @Previewable @State var isPresented = false

    Button("Add Book") {
        isPresented = true
    }
    .sheet(isPresented: $isPresented) {
        BookComposerView { _, _, _, _, _ in
            .failure(message: "This is a simulated save failure.")
        }
    }
}
