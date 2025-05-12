//
//  FriendListView.swift
//  Interactive Journal
//
//  Created by Adam Merhi on 11/5/2025.
//

import SwiftUI

struct FriendsListView: View {
    @ObservedObject var viewModel: FriendsListModel
    @State private var searchText: String = ""

    init(currentUserId: Int) {
        _viewModel = ObservedObject(wrappedValue: FriendsListModel(currentUserId: currentUserId))
    }

    var body: some View {
        NavigationStack {
            VStack {
                // Search Bar
                TextField("Search friends...", text: $searchText)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding([.horizontal, .top])
                    .onChange(of: searchText) { newValue in
                        viewModel.searchUsers(by: newValue)
                    }

                // Separate users into friends and possible friends
                let filteredUsers = viewModel.getFilteredUsers()

                // Friends Section
                if !filteredUsers.friends.isEmpty {
                    Section(header: Text("Your Friends")) {
                        List(filteredUsers.friends) { user in
                            Text(user.username)
                        }
                    }
                }

                // Possible Friends Section
                if !filteredUsers.possibleFriends.isEmpty {
                    Section(header: Text("Possible Friends")) {
                        List(filteredUsers.possibleFriends) { user in
                            HStack {
                                Text(user.username)
                                Spacer()
                                Button(action: {
                                    viewModel.addFriend(friendId: user.id)
                                }) {
                                    Text("Add Friend")
                                        .padding(5)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Friends List")
            .onChange(of: viewModel.currentUserId) { newId in
                viewModel.loadUsers() // Reload users list when the current user ID changes
            }
        }
    }
}


#Preview {
    FriendsListView(currentUserId: 1)
}
