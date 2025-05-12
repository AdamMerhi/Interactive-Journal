//
//  FriendsListUserDefaultsManager.swift
//  Interactive Journal
//
//  Created by Adam Merhi on 11/5/2025.
//

import Foundation

class FriendsListUserDefaultsManager {
    
    private let friendsKey = "friendsList"
    
    // Function to save friends list for a user
    func saveFriends(for userId: Int, friends: [Int]) {
        var allFriends = loadAllFriends()
        allFriends[userId] = friends
        saveAllFriends(allFriends)
    }
    
    // Function to load the friends list for a user
    func loadFriends(for userId: Int) -> [Int] {
        let allFriends = loadAllFriends()
        return allFriends[userId] ?? []
    }
    
    // Function to add a new friend for a user
    func addFriend(for userId: Int, friendId: Int) {
        // Add friendId to userId's list
        var userFriends = loadFriends(for: userId)
        if !userFriends.contains(friendId) {
            userFriends.append(friendId)
            saveFriends(for: userId, friends: userFriends)
        }
    }

    // Function to load all the friends data (for all users)
    private func loadAllFriends() -> [Int: [Int]] {
        if let data = UserDefaults.standard.data(forKey: friendsKey),
           let friends = try? JSONDecoder().decode([Int: [Int]].self, from: data) {
            return friends
        }
        return [:]
    }
    
    // Function to save all friends data
    private func saveAllFriends(_ friends: [Int: [Int]]) {
        if let data = try? JSONEncoder().encode(friends) {
            UserDefaults.standard.set(data, forKey: friendsKey)
        }
    }
}
