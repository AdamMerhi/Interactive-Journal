//
//  JournalModel.swift
//  Interactive Journal
//
//  Created by Adam Merhi on 11/5/2025.
//

import Foundation

struct Journal: Identifiable, Codable {
    var id = UUID()
    var user: String
    var title: String
    var content: String
    var createdAt: Date
    var locationName: String? = nil
}
