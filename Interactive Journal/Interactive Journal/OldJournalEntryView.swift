// Created by Chloe Truong 24961967

import SwiftUI

struct OldJournalView: View {
    var currentUserId: String
    @State private var userJournals: [Journal] = []

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Journal Archive")
                    .font(.title)
                    .padding(.top)

                if userJournals.isEmpty {
                    Text("No entries found.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(userJournals.sorted(by: { $0.createdAt > $1.createdAt })) { journal in
                            NavigationLink(destination: ClickedJournal(entry: convertToEntry(journal))) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(journal.title)
                                        .font(.headline)
                                    Text(journal.createdAt.formatted(date: .abbreviated, time: .shortened))
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    Text("📍 \(journal.locationName)")
                                        .font(.caption2)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                userJournals = DatabaseManager.shared.getJournals(for: currentUserId)
            }
            .padding(.horizontal)
        }
    }

    // Convert `Journal` to `JournalEntry` for ClickedJournal (if needed)
    private func convertToEntry(_ journal: Journal) -> JournalEntry {
        return JournalEntry(date: journal.createdAt, title: journal.title, body: journal.content, userId: journal.user, locationName: journal.locationName ?? "unknown")
    }
}

#Preview {
    let journalData = JournalData()
    let currentUserId = "user123" // Example user ID for preview

    OldJournalView(currentUserId: currentUserId)
        .environmentObject(journalData)
}
