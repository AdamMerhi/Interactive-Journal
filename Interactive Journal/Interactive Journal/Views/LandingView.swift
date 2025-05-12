//
//  LandingView.swift
//  iOS journal
//
//  Created by Ceri Tahimic on 9/5/2025.
//

import SwiftUI

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct LandingView: View {
    let userName: String
    let currentUserId: Int

    @State private var showMenu = false
    @State private var navigateToJournalView = false
    @State private var navigateToFriendsList = false
    @StateObject private var journalData = JournalData()
    @EnvironmentObject var loginModel: LoginModel
    @Binding var isLoggedIn: Bool
    @Environment(\.dismiss) var dismiss

    
    //var userName: String
    private let userDefaultsManager = UserDefaultsManager()
    private let friendsListUserDefaultsManager = FriendsListUserDefaultsManager()
    private let databaseManager = DatabaseManager.shared

    /*var currentUserId: Int {
        guard let user = userDefaultsManager.loadUsers().first(where: { $0.username == userName }) else {
            print("Error: Current user not found!")
            return -1
        }
        return user.id
    }*/
    
    init(isLoggedIn: Binding<Bool>, userName: String, currentUserId: Int) {
        self._isLoggedIn = isLoggedIn
        self.userName = userName
        self.currentUserId = currentUserId
    }


    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                HStack {
                    NavigationLink(
                        destination: FriendsListView(currentUserId: currentUserId),
                        isActive: $navigateToFriendsList
                    ) {
                        EmptyView()
                    }

                    Button { navigateToFriendsList = true } label: {
                        Image(systemName: "person.2")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal)

                    Spacer()

                    Button(action: {
                        loginModel.logout()
                        isLoggedIn = false
                        dismiss()
                    }) {
                        Image(systemName: "arrow.backward.circle")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    
                    NavigationLink(
                        destination: NewJournalView(currentUserId: currentUserId, userName: userName)
                            .environmentObject(journalData),
                        isActive: $navigateToJournalView
                    ) {
                        EmptyView()
                    }
                    
                    Button(action: {
                        navigateToJournalView = true
                    }) {
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)
                
                Text("Welcome \(userName)")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                // Your Journal
                NavigationLink(destination: OldJournalView(currentUserId: currentUserId)
                    .environmentObject(journalData)) {
                        VStack(alignment: .leading) {
                            Text("Your Journal")
                                .underline()
                                .font(.title3)
                                .foregroundColor(.blue)
                            Text("See your previous Journal Entries")
                                .font(.subheadline)
                                .foregroundColor(.black)
                        }
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(20)
                        .shadow(color: .blue.opacity(0.4), radius: 5, x: 5, y: 5)
                        .padding(.horizontal)
                    }

                // Divider
                HStack {
                    Spacer()
                    Image(systemName: "diamond.fill")
                        .foregroundColor(.white)
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 2)
                    Image(systemName: "diamond.fill")
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.horizontal)

                // Today's Journals
                Text("Today's Journals")
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding(.horizontal)

                ScrollView(.vertical, showsIndicators: false) {
                    HStack(spacing: 20) {
                        // Get list of friends
                        let friendIds = friendsListUserDefaultsManager.loadFriends(for: currentUserId)

                        ForEach(friendIds, id: \.self) { friendId in
                            // Get journals for each friend
                            let friendsJournals = databaseManager.getJournals(for: friendId)
                            
                            VStack {
                                Text("Friend \(friendId)'s Journals")  // This could be replaced with friend's name
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(.bottom, 5)
                                
                                ForEach(friendsJournals, id: \.id) { journal in
                                    VStack(alignment: .leading) {
                                        Text(journal.title)
                                            .font(.subheadline)
                                            .foregroundColor(.white)
                                        Text(journal.content)
                                            .font(.body)
                                            .foregroundColor(.gray)
                                            .lineLimit(3)
                                    }
                                    .padding()
                                    .background(Color(.systemGray5))
                                    .cornerRadius(10)
                                    .shadow(color: .blue.opacity(0.4), radius: 5, x: 5, y: 5)
                                    .padding(.bottom, 10)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                Spacer()
            }
            .padding(.top)
            .background(Color(red: 102/255, green: 129/255, blue: 165/255))
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    LandingView(isLoggedIn: .constant(true), userName: "Test", currentUserId: 1)
    .environmentObject(LoginModel())}
