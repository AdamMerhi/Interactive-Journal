//
//  SideMenuView.swift
//  Interactive Journal
//
//  Created by Adam Merhi on 12/5/2025.
//

import SwiftUI

struct SideMenuView: View {
    var userName: String
    @Binding var showMenu: Bool
    @Binding var navigateToFriendsList: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            HStack {
                Text("*\(userName)*")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                Button(action: {
                    withAnimation { showMenu = false }
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .font(.headline)
                }
            }

            Divider().background(Color.white)

            Button(action: {
                withAnimation {
                    showMenu = false
                    navigateToFriendsList = true
                }
            }) {
                HStack {
                    Image(systemName: "person.2")
                        .foregroundColor(.white)
                    Text("Friends List")
                        .foregroundColor(.white)
                }
            }

            Spacer()
        }
        .padding(.top, 60)
        .padding(.horizontal)
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}


/*struct JournalArchive: View {
    var userName: String
    
    var body: some View {
        Text("\(userName)'s Journal")
            .navigationTitle("Your Journals")
    }
}
*/

#Preview {
    SideMenuView(userName: "Test User", showMenu: .constant(true), navigateToFriendsList: .constant(false))
}
