//
//  ContentView.swift
//  iOS journal
//
//  Created by Ceri Tahimic on 9/5/2025.
//

import SwiftUI

struct LandingView: View {
    var userName: String = "placeholder"
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                //header with menu and plus button
                HStack {
                    Button (action: {
                        //navgiation menu logic
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Button (action: {
                        //create new journal entry
                    }) {
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                }
                
                .padding(.horizontal)
                
                //Welcome Message
                Text("Welcome to *insert app name*")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                //"Your Journal" Card
                NavigationLink(destination: JournalArchiveView(userName: userName)) {
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
                
                HStack {
                    Spacer ()
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
                
                //Today's Journals
                Text("Today's Journals")
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                Spacer()
                
            }
            .padding(.top)
            .background(Color(red: 102/255 , green: 129/255 , blue: 165/255))
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarHidden(true)
        }
    }
}

struct JournalArchiveView: View {
    var userName: String
    
    var body: some View {
        Text("\(userName)'s Journal Entries")
            .navigationTitle("Your Journal")
    }
}

#Preview {
    LandingView()
}
