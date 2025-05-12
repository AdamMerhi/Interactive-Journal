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
    @State private var showMenu = false
    @State private var navigateToJournalView = false
    @State private var navigateToFriendsList = false
    @StateObject private var journalData = JournalData()
    @EnvironmentObject var loginModel: LoginModel
    @Binding var isLoggedIn: Bool
    
    var userName: String
    private let userDefaultsManager = UserDefaultsManager()
    
    var currentUserId: Int {
        userDefaultsManager.loadUsers().first { $0.username == userName }?.id ?? 1
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                HStack {
                    Button(action: {
                        withAnimation {
                            showMenu.toggle()
                        }
                    }){
                        Image(systemName: "line.horizontal.3")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        loginModel.logout()
                        isLoggedIn = false
                    }) {
                        Image(systemName: "arrow.backward.circle")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    
                    
                    NavigationLink(
                        destination: NewJournalView(currentUserId: userName)
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
                NavigationLink(destination: OldJournalView(currentUserId: userName)
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
                
                Text("\(userName)’s Entry")
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top)
            .background(Color(red: 102/255, green: 129/255, blue: 165/255))
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarHidden(true)
        }
        // Side Menu Overlay
        if showMenu {
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation {
                        showMenu = false
                    }
                }
            
            SideMenuView(userName: userName, showMenu: $showMenu, navigateToFriendsList: $navigateToFriendsList) // Pass binding
                .transition(.move(edge: .leading))
        }
        
        NavigationLink(destination: FriendsListView(currentUserId: currentUserId), isActive: $navigateToFriendsList) {
            EmptyView()
        }
    }
}

#Preview {
    LandingView(isLoggedIn: .constant(true), userName: "User")
        .environmentObject(LoginModel())
}
