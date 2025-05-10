//
//  JournalModel.swift
//  Interactive Journal
//
//  Created by Adam Merhi on 11/5/2025.
//

import Foundation

struct Journal: Identifiable, Codable {
    var id = UUID()  // Unique identifier for each journal entry
    var user: String // User's ID
    var title: String
    var content: String
    var createdAt: Date // Timestamp for when the journal is created
}
