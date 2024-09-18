//
//  NetworkManager.swift
//  WhereWeatherApp
//
//  Created by Tony Lieu on 9/17/24.
//

import Foundation

protocol Networking {
    func fetchWeather(urlStr: String) async throws -> WeatherResponse
}

final class NetworkManager: Networking {
    private lazy var decoder = JSONDecoder()
    
    func fetchWeather(urlStr: String) async throws -> WeatherResponse {
        guard let url = URL(string: urlStr) else {
            throw URLError(.badURL)
        }
        let (data, response) = try await URLSession(configuration: .ephemeral).data(from: url)
        guard let urlResponse = response as? HTTPURLResponse else {
            throw URLError(.cannotParseResponse)
        }
        guard (200...299).contains(urlResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        return try decoder.decode(WeatherResponse.self, from: data)
    }
}
