
// Created by Chloe Truong 24961967

import SwiftUI

class JournalData: ObservableObject {
    @Published var entries: [JournalEntry] = []
}

struct JournalEntry: Identifiable {
    let id: Date
    let title: String
    let body: String
    
    init(date: Date = Date(), title: String = "", body: String = "") {
        self.id = date
        self.title = title
        self.body = body
    }
}
    
struct NewJournalView: View {
    @EnvironmentObject var journalData: JournalData
    @State private var content: String = ""
    @State private var navigateToOldJournal: Bool = false
    
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

                    let newEntry = JournalEntry(title: title, body: content)
                    journalData.entries.append(newEntry)
                    navigateToOldJournal = true
                    
                }) {
                    Text("Save")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    
                }
                .navigationDestination(isPresented: $navigateToOldJournal) {
                        OldJournalView()
                        .environmentObject(journalData)
                }
            }
            
        }
        
    }
}
private func DateFormatStyle() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "d MMMM yyyy"
    return formatter.string(from: Date())
}


    






