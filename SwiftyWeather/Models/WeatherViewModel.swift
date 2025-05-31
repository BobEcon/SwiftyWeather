//
//  WeatherViewModel.swift
//  SwiftyWeather
//
//  Created by Robert Beachill on 31/05/2025.
//

import Foundation

@Observable
class WeatherViewModel {
    private struct Returned: Codable {
        var current: Current
    }
    
    struct Current: Codable {
        var temperature_2m: Double
        var apparent_temperature: Double
        var weather_code: Int
        var wind_speed_10m: Double
    }
    
    var urlString = "https://api.open-meteo.com/v1/forecast?latitude=42.3306&longitude=-71.1662&daily=weather_code,temperature_2m_max,temperature_2m_min,precipitation_sum&hourly=uv_index&current=temperature_2m,relative_humidity_2m,apparent_temperature,precipitation,weather_code,wind_speed_10m&timezone=auto&wind_speed_unit=mph&temperature_unit=fahrenheit&precipitation_unit=inch"
    
    var temperature_2m = 0.0
    var apparent_temperature = 0.0
    var weather_code = 0
    var wind_speed_10m = 0.0
    
    func getData() async {
        print("we are accessing the url \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("ERROR: Could not create a URL")
            return
        }
        
        do {
            let (data,_) = try await URLSession.shared.data(from: url)
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                print("JSON ERROR; Could not decode returned JSON data")
                return
            }
            Task { @MainActor in 
            self.temperature_2m = returned.current.temperature_2m
            self.apparent_temperature = returned.current.apparent_temperature
            self.weather_code = returned.current.weather_code
            self.wind_speed_10m = returned.current.wind_speed_10m
        }
        } catch {
            print("ERROR: Could not get data from URL")
        }
    }
}
