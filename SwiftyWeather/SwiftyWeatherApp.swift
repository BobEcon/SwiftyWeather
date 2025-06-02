//
//  SwiftyWeatherApp.swift
//  SwiftyWeather
//
//  Created by Robert Beachill on 30/05/2025.
//

import SwiftUI
import SwiftData

@main
struct SwiftyWeatherApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherView()
                .modelContainer(for: Preference.self)
        }
    }
    
    // Will allow us to find where our simulator data is saved
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
