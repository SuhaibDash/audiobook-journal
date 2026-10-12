//
//  EntryComposerView.swift
//  AudiobookJournal
//
//  Created by Suhaib Dashash on 9/14/26.
//

import SwiftUI

struct EntryComposerView: View {
    let onSave: (EntryType, Int?, String) -> SaveResult

    @Environment(\.dismiss) private var dismiss
    @State private var entryType: EntryType = .note
    @State private var chapterText = ""
    @State private var bodyText = ""
    @State private var saveErrorMessage = ""
    @State private var isShowingSaveError = false

    private var trimmedBody: String {
        bodyText.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var isChapterValid: Bool {
        let text = chapterText.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        if text.isEmpty {
            return true
        }

        guard let number = Int(text) else {
            return false
        }

        return number > 0
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

                    if !isChapterValid {
                        Text("Chapter must be a positive whole number.")
                            .font(.caption)
                            .foregroundStyle(.red)
                    }
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
                        let result = onSave(
                            entryType,
                            Int(chapterText.trimmingCharacters(in: .whitespacesAndNewlines)),
                            trimmedBody
                        )

                        switch result {
                        case .success:
                            dismiss()

                        case .failure(let message):
                            saveErrorMessage = message
                            isShowingSaveError = true
                        }
                    }
                    .disabled(trimmedBody.isEmpty || !isChapterValid)
                }
            }
            .alert(
                "Couldn't save entry, please try again.",
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

    Button("Add Thought") {
        isPresented = true
    }
    .sheet(isPresented: $isPresented) {
        EntryComposerView { _, _, _ in
            .failure(message: "This is a simulated save failure.")
        }
    }
}
