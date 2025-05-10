
// Created by Chloe Truong 24961967

import SwiftUI

struct ClickedJournal: View {
    @EnvironmentObject var journalData: JournalData
    var entry: JournalEntry

    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
                    Text(entry.title)
                        .font(.title)
                        .bold()

                    Text(entry.id.formatted(date: .abbreviated, time: .shortened))
                        .font(.caption)
                        .foregroundColor(.gray)

                    ScrollView {
                        Text(entry.body)
                            .font(.body)
                            .padding(.top, 10)
                    }

                    Spacer()
                }
                .padding()
                .navigationTitle("Journal Entry")

    }
}

#Preview {
    let journalData = JournalData()
    let exampleEntry = JournalEntry(date: Date(), title: "Sample Entry", body: "This is a sample journal entry.", userId: "user123")

    ClickedJournal(entry: exampleEntry)
        .environmentObject(journalData)
}
