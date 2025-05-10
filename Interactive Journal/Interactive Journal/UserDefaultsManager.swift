//
//  UserDefaultsManager.swift
//  Interactive Journal
//
//  Created by Adam Merhi on 7/5/2025.
//

import Foundation

class UserDefaultsManager {
    
    //The key to store the users in UserDefaults
    private let usersKey = "users"
    
    //Save users to UserDefaults
    func saveUsers(users: [User]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(users) {
            UserDefaults.standard.set(encoded, forKey: usersKey)
        }
    }
    
    //Load users from UserDefaults
    func loadUsers() -> [User] {
        if let savedUsers = UserDefaults.standard.data(forKey: usersKey) {
            let decoder = JSONDecoder()
            if let loadedUsers = try? decoder.decode([User].self, from: savedUsers) {
                return loadedUsers
            }
        }
        return []
    }
}
