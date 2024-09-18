//
//  MockDataWeather.swift
//  WhereWeatherApp
//
//  Created by Tony Lieu on 9/17/24.
//

import Foundation

class MockParams {
    static let data = """
       {
         "coord": {
           "lon": -74.006,
           "lat": 40.7143
         },
         "weather": [
           {
             "id": 800,
             "main": "Clear",
             "description": "clear sky",
             "icon": "01d"
           }
         ],
         "base": "stations",
         "main": {
           "temp": 27.9,
           "feels_like": 27.64,
           "temp_min": 22.75,
           "temp_max": 33.04,
           "pressure": 1019,
           "humidity": 41
         },
         "visibility": 10000,
         "wind": {
           "speed": 3.09,
           "deg": 40
         },
         "clouds": {
           "all": 0
         },
         "dt": 1685641325,
         "sys": {
           "type": 1,
           "id": 4610,
           "country": "US",
           "sunrise": 1685611643,
           "sunset": 1685665237
         },
         "timezone": -14400,
         "id": 5128581,
         "name": "New York",
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
