//
//  MockDataWeather.swift
//  WhereWeatherApp
//
//  Created by Tony Lieu on 9/17/24.
//

import Foundation

class MockResponse {
    static let data = """
           {
             "coord": {
               "lon": -84.388,
               "lat": 33.749
             },
             "weather": [
               {
                 "id": 804,
                 "main": "Clouds",
                 "description": "overcast clouds",
                 "icon": "04d"
               }
             ],
             "base": "stations",
             "main": {
               "temp": 23.28,
               "feels_like": 23.6,
               "temp_min": 22.03,
               "temp_max": 24.58,
               "pressure": 1014,
               "humidity": 74,
               "sea_level": 1014,
               "grnd_level": 981
             },
             "visibility": 10000,
             "wind": {
               "speed": 0.45,
               "deg": 263,
               "gust": 1.79
             },
             "clouds": {
               "all": 99
             },
             "dt": 1726674888,
             "sys": {
               "type": 2,
               "id": 2006620,
               "country": "US",
               "sunrise": 1726658597,
               "sunset": 1726702793
             },
             "timezone": -14400,
             "id": 4180439,
             "name": "Atlanta",
             "cod": 200
           }
    """.data(using: .utf8)!
}

class MockLocationMap: LocationMapService {
    var delegate: LocationManagerProtocol?
    var locationRetrieveCalled = false
    
    init() {
        locationRetrieve()
    }
    
    func locationRetrieve() {
        locationRetrieveCalled = true
        delegate?.locationUpdated(lat: 33.7488, lon: 84.3877)
    }
}

class MockNetwork: Networking {
    var weatherToReturn: WeatherResponse?
    var fetchWeatherCalled = false
    
    func fetchWeather(urlStr: String) async throws -> WeatherResponse {
        fetchWeatherCalled = true
        if let weather = weatherToReturn {
            return weather
        } else {
            throw NSError(domain: "MockNetworkManager", code: 0, userInfo: nil)
        }
    }
}
