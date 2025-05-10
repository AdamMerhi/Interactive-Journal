// Created by Chloe Truong 24961967

import SwiftUI

struct OldJournalView: View {
    @EnvironmentObject var journalData: JournalData

    var body: some View {
        NavigationStack {
            Text("Journal Archive")
                .font(.title)
            
            List {
                ForEach(journalData.entries.sorted(by: { $0.id > $1.id })) { entry in
                    NavigationLink(destination: ClickedJournal(entry: entry)) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(entry.title)
                                .font(.headline)
                            Text(entry.id.formatted(date: .abbreviated, time: .shortened))
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
    }
}
