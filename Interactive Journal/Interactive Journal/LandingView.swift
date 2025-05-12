//
//  ContentView.swift
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
    
    var userName: String
    private let userDefaultsManager = UserDefaultsManager()

    var currentUserId: Int {
        userDefaultsManager.loadUsers().first { $0.username == userName }?.id ?? 1
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack(alignment: .leading, spacing: 20) {
                    // Header
                    HStack {
                        Button(action: {
                            withAnimation {
                                showMenu.toggle()
                            }
                        }) {
                            Image(systemName: "line.horizontal.3")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        Spacer()
                        
                        NavigationLink(
                            destination: NewJournalView(currentUserId: userName)
                                .environmentObject(journalData),  // <- Pass the JournalData object here
                            isActive: $navigateToJournalView
                        ){
                            EmptyView()
                        }
                        
                        Button(action: {
                            navigateToJournalView = true
                        }){
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
}

struct SideMenuView: View {
    var userName: String
    @Binding var showMenu: Bool
    @Binding var navigateToFriendsList: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            // Header with username and close button
            HStack {
                Text("*\(userName)*")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                Button(action: {
                    withAnimation {
                        showMenu = false
                    }
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .font(.headline)
                }
            }
            
            Divider().background(Color.white)
            
            // Friends List Button
            Button(action: {
                withAnimation {
                    showMenu = false // Close the menu when tapped
                    navigateToFriendsList = true // Trigger navigation to Friends List
                }
            }) {
                HStack {
                    Image(systemName: "person.2")
                        .foregroundColor(.white)
                    Text("Friends List")
                        .foregroundColor(.white)
                }
            }

            /*
            // Settings Button
            Button(action: {
                print("Settings tapped")
                // Add navigation logic here
            }) {
                HStack {
                    Image(systemName: "gearshape")
                        .foregroundColor(.white)
                    Text("Settings")
                        .foregroundColor(.white)
                }
            }
             */
            
            Spacer()
        }
        .padding(.top, 60)
        .padding(.horizontal)
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

struct JournalArchive: View {
    var userName: String
    
    var body: some View {
        Text("\(userName)'s Journal")
            .navigationTitle("Your Journals")
    }
}

#Preview {
    LandingView(userName: "User")
}
