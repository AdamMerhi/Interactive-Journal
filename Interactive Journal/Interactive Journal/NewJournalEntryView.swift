
// Created by Chloe Truong 24961967

import SwiftUI

class JournalData: ObservableObject {
    @Published var entries: [JournalEntry] = []
    
    func entries(for userId: String) -> [JournalEntry] {
        return entries.filter { $0.userId == userId }
    }
}

struct JournalEntry: Identifiable {
    let id: Date
    let title: String
    let body: String
    let userId: String
    
    init(date: Date = Date(), title: String = "", body: String = "", userId: String) {
        self.id = date
        self.title = title
        self.body = body
        self.userId = userId
    }
}

struct NewJournalView: View {
    @EnvironmentObject var journalData: JournalData
    @State private var content: String = ""
    @State private var navigateToLandingPage: Bool = false
    var currentUserId: String
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("New Journal Entry")
                    .font(.title)
                    .padding(20)
                
                HStack {
                    Image(systemName: "calendar")
                    Text(DateFormatStyle())
                }
                .padding()
                
                TextEditor(text: $content)
                    .padding()
                    .frame(minHeight: 200)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                    .padding(20)
                Spacer()
                
                Button(action: {
                    let lineBreak = content.split(separator: "\n", maxSplits: 1, omittingEmptySubsequences: true)
                    let title = lineBreak.first.map(String.init) ?? "Untitled"
                    
                    DatabaseManager.shared.addJournal(for: currentUserId, title: title, content: content)
                    navigateToLandingPage = true
                }) {
                    Text("Save")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .navigationDestination(isPresented: $navigateToLandingPage) {
                    LandingView(userName: currentUserId)
                        .environmentObject(journalData)
                }
            }
        }
        //.navigationBarBackButtonHidden(true)
    }
}

private func DateFormatStyle() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "d MMMM yyyy"
    return formatter.string(from: Date())
}

#Preview {
    let journalData = JournalData()
    let currentUserId = "preview_user"

    NewJournalView(currentUserId: currentUserId)
        .environmentObject(journalData)
}
