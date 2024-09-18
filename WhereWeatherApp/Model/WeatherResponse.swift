//
//  WeatherModel.swift
//  WhereWeatherApp
//
//  Created by Tony Lieu on 9/17/24.
//


import Foundation

struct WeatherResponse: Decodable, Equatable {
    let name: String
    let coord: Coordinate?
    let main: Main?
    let wind: Wind?
    let weather: [Weather]?
    let visibility: Double
}

struct Coordinate: Decodable, Equatable {
    let lon, lat : Double
}

struct Main: Decodable, Equatable {
    let temp, feels_like, humidity: Double
}

struct Wind: Decodable, Equatable {
    let speed: Double
}

struct Weather: Decodable, Equatable {
    let main, description, icon: String
}
