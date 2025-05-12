//
//  DatabaseManager.swift
//  Interactive Journal
//
//  Created by Adam Merhi on 11/5/2025.
//

import Foundation

class DatabaseManager: ObservableObject {
    static let shared = DatabaseManager()

    @Published private(set) var journals: [Journal] = []
    private let journalDefaultsManager = JournalDefaultsManager()

    private init() {
        loadJournals()
    }

    // Load journals for the current user
    func loadJournals() {
        journals = journalDefaultsManager.loadJournals()
    }

    // Get journals for a specific user
    func getJournals(for user: String) -> [Journal] {
        return journals.filter { $0.user == user }
    }

    // Add a new journal entry for the current user
    func addJournal(for user: String, title: String, content: String, locationName: String) {
        let newJournal = Journal(user: user, title: title, content: content, createdAt: Date(), locationName: locationName)
        journals.append(newJournal)
        save()
    }

    // Delete a journal by its ID
    func deleteJournal(id: UUID) {
        journals.removeAll { $0.id == id }
        save()
    }

    // Save the journals to UserDefaults
    private func save() {
        journalDefaultsManager.saveJournals(journals: journals)
    }
}
