//
//  JournalDefaultsManager.swift
//  Interactive Journal
//
//  Created by Adam Merhi on 11/5/2025.
//

import Foundation

class JournalDefaultsManager {
    
    private let journalsKey = "journals"
    
    // Save journals to UserDefaults
    func saveJournals(journals: [Journal]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(journals) {
            UserDefaults.standard.set(encoded, forKey: journalsKey)
        }
    }
    
    // Load journals from UserDefaults
    func loadJournals() -> [Journal] {
        if let savedJournals = UserDefaults.standard.data(forKey: journalsKey) {
            let decoder = JSONDecoder()
            if let loadedJournals = try? decoder.decode([Journal].self, from: savedJournals) {
                return loadedJournals
            }
        }
        return []
    }
}
