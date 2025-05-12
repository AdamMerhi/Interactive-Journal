// Created by Chloe Truong 24961967

import SwiftUI
import CoreLocation

class JournalData: ObservableObject {
    @Published var entries: [JournalEntry] = []
    
    func entries(for userId: Int) -> [JournalEntry] {
        return entries.filter { $0.userId == userId }
    }
}

struct JournalEntry: Identifiable {
    let id: Date
    let title: String
    let body: String
    let userId: Int
    let temperature: Double
    let condition: String
    let locationName: String

    init(date: Date = Date(), title: String = "", body: String = "", userId: Int, temperature: Double = 0.0, condition: String = "", locationName: String = "") {
        self.id = date
        self.title = title
        self.body = body
        self.userId = userId
        self.temperature = temperature
        self.condition = condition
        self.locationName = locationName
    }
}

struct NewJournalView: View {
    @EnvironmentObject var journalData: JournalData
    @State private var content: String = ""
    @State private var navigateToLandingPage: Bool = false
    @StateObject private var locationManager = LocationManager()
    @State private var weatherData: WeatherData?
    @State private var isLoggedIn: Bool = true
    
    var currentUserId: Int
    var userName: String

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

                HStack {
                    if let weather = weatherData {
                        Text("📍 \(weather.locationName)")
                        Spacer()
                        Text("🌡️ \(Int(weather.temperature))°C, \(weather.condition)")
                    } else {
                        ProgressView("Searching Weather...")
                    }
                }
                .padding(.horizontal)

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

                    let entry = JournalEntry(
                        title: title,
                        body: content,
                        userId: currentUserId,
                        temperature: weatherData?.temperature ?? 0.0,
                        condition: weatherData?.condition ?? "Unknown",
                        locationName: weatherData?.locationName ?? "Unknown"
                    )
                    DatabaseManager.shared.addJournal(for: currentUserId, title: title, content: content, locationName: weatherData?.locationName ?? "Unknown")

                    journalData.entries.append(entry)
                    navigateToLandingPage = true
                }) {
                    Text("Save")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.bottom)

                NavigationLink(destination: LandingView(isLoggedIn: $isLoggedIn, userName: userName, currentUserId: currentUserId)
                    .environmentObject(journalData),
                               isActive: $navigateToLandingPage) {
                    EmptyView()
                }
            }
            .onAppear {
                locationManager.requestLocation()
            }
            .onChange(of: locationManager.location) { location in
                if let loc = location {
                    print("Location updated: \(loc.coordinate.latitude), \(loc.coordinate.longitude)") // Debugging location
                    fetchWeatherData(for: loc)
                } else {
                    print("Location is nil.") // Debugging location nil case
                }
            }
        }
    }

    private func fetchWeatherData(for location: CLLocation) {
        let apiKey = "bb3d538833dfdb7a603454a2ac5550e8"
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&units=metric&appid=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL string.")
            return
        }
        
        print("Fetching weather data for URL: \(url)") // Debugging URL request

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Weather fetch error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data returned.")
                return
            }

            do {
                let decoded = try JSONDecoder().decode(WeatherResponse.self, from: data)
                print("Decoded weather response: \(decoded)")

                DispatchQueue.main.async {
                    self.weatherData = WeatherData(
                        locationName: decoded.name,
                        temperature: decoded.main.temp,
                        condition: decoded.weather.first?.description ?? "Clear"
                    )
                    print("Weather data fetched: \(self.weatherData!)") // Debugging fetched weather
                }
            } catch {
                print("JSON decode error: \(error.localizedDescription)")
            }
        }.resume()
    }

    private func DateFormatStyle() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
        return formatter.string(from: Date())
    }
}

#Preview {
    let journalData = JournalData()
    let currentUserId = 1
    let userName = "test"

    NewJournalView(currentUserId: currentUserId, userName: userName)
        .environmentObject(journalData)
}
