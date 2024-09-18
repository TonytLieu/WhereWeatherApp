//
//  WeatherViewModel.swift
//  WhereWeatherApp
//
//  Created by Tony Lieu on 9/17/24.
//

import Foundation

final class WeatherViewModel: ObservableObject, LocationManagerProtocol {
    
    private let userDef = UserDefaults.standard
    @Published var weatherDisplay: WeatherResponse?
    
    private let networkManager: Networking
    private var locationManager: LocationMapService
    
    init(networkManager: Networking, locationManager: LocationMapService) {
        self.networkManager = networkManager
        self.locationManager = locationManager
    
        self.locationManager.delegate = self
        guard let name = userDef.string(forKey: "city") else { return }
        Task {
            await weatherCity(city: name)
        }
    }
    
    func weatherCoordinates(lat: Double, lon: Double) async {
        do {
            var urlString = APIEndpoints.baseURL
            urlString += "lat=\(lat)&"
            urlString += "lon=\(lon)&"
            urlString += "appid=\(APIEndpoints.apiKey)&"
            urlString += "units=metric"
            let weather = try await networkManager.fetchWeather(urlStr: urlString)
            userDef.set(weather.name, forKey: "city")
            DispatchQueue.main.async { [weak self] in
                self?.weatherDisplay = weather
            }
        } catch {
            print("Failed to fetch data using coordinates: \(error.localizedDescription)")
        }
    }
    
    func weatherCity(city: String) async {
        let refinedCityString = city.replacingOccurrences(of: " ", with: "%20")
        do {
            var urlString = APIEndpoints.baseURL
            urlString += "q=\(refinedCityString)&"
            urlString += "appid=\(APIEndpoints.apiKey)&"
            urlString += "units=metric"
            let weather = try await networkManager.fetchWeather(urlStr: urlString)
            userDef.set(weather.name, forKey: "city")
            DispatchQueue.main.async { [weak self] in
                self?.weatherDisplay = weather
            }
        } catch {
            print("Failed to fetch data using city name: \(error.localizedDescription)")
        }
    }
    
    func locationUpdated(lat: Double, lon: Double) {
        Task {
            await weatherCoordinates(lat: lat, lon: lon)
        }
    }
    
    func locationFailed() {
        print("Failed to fetch location.")
    }
}
