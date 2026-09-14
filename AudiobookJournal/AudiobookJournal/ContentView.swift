//
//  ContentView.swift
//  AudiobookJournal
//
//  Created by Suhaib Dashash on 9/13/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Audiobook Journal")
                .font(.title)

            Text("Remember the stories you love.")
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
