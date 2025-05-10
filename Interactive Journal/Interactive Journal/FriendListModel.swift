//
//  FriendListModel.swift
//  Interactive Journal
//
//  Created by Adam Merhi on 11/5/2025.
//

import Foundation
import Combine

class FriendsListModel: ObservableObject {
    @Published var allUsers: [User] = []
    @Published var searchResults: [User] = []
    
    private let userDefaultsManager = UserDefaultsManager()
    private let friendsListManager = FriendsListUserDefaultsManager()

    var currentUserId: Int
    
    init(currentUserId: Int) {
        self.currentUserId = currentUserId
        loadUsers()
    }

    func loadUsers() {
        allUsers = userDefaultsManager.loadUsers()
        searchResults = allUsers
    }

    func searchUsers(by name: String) {
        if name.isEmpty {
            searchResults = allUsers
        } else {
            searchResults = allUsers.filter { $0.username.lowercased().contains(name.lowercased()) }
        }
    }

    // Function to add a friend
    func addFriend(friendId: Int) {
        friendsListManager.addFriend(for: currentUserId, friendId: friendId)
    }

    // Get the list of friends for the current user
    func getFriends() -> [User] {
        let friendIds = friendsListManager.loadFriends(for: currentUserId)
        return allUsers.filter { friendIds.contains($0.id) }
    }

    // Separate users into friends and possible friends
    func getFilteredUsers() -> (friends: [User], possibleFriends: [User]) {
        let friendIds = friendsListManager.loadFriends(for: currentUserId)
        let friends = allUsers.filter { friendIds.contains($0.id) }
        let possibleFriends = allUsers.filter { !friendIds.contains($0.id) }
        return (friends, possibleFriends)
    }
}
