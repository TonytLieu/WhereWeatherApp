//
//  WhereWeatherAppTests.swift
//  WhereWeatherAppTests
//
//  Created by Tony Lieu on 9/18/24.
//

import XCTest
@testable import WhereWeatherApp

final class WhereWeatherAppTests: XCTestCase {
        
    func testWeatherForCity_isSuccess() async throws {
        //Given
        let networkManager = MockNetwork()
        let locationManager = MockLocationMap()
        
        let expectedWeather = try! JSONDecoder().decode(WeatherResponse.self, from: MockParams.data)
        networkManager.weatherToReturn = expectedWeather
        
        let viewModel = WeatherViewModel(networkManager: networkManager,
                                         locationManager: locationManager)
        
        //When
        await viewModel.weatherCity(city: "Atlanta")
        
        guard let weatherDisplay = viewModel.weatherDisplay else { return }
        
        //Then
        XCTAssertTrue(networkManager.fetchWeatherCalled)
        XCTAssertTrue(locationManager.locationRetrieveCalled)
        
        XCTAssertEqual(weatherDisplay, expectedWeather)
        
        XCTAssertEqual(UserDefaults.standard.string(forKey: "city"), "Atlanta")
    }

    func testWeatherForCoordinates_isSuccess() async throws {
        //Given
        let networkManager = MockNetwork()
        let locationManager = MockLocationMap()
        
        let expectedWeather = try! JSONDecoder().decode(WeatherResponse.self, from: MockParams.data)
        networkManager.weatherToReturn = expectedWeather
        
        let viewModel = WeatherViewModel(networkManager: networkManager,
                                  locationManager: locationManager)
        
        //When
        await viewModel.weatherCoordinates(lat: 33.749, lon: -84.388)
        
        guard let weatherDisplay = viewModel.weatherDisplay else { return }
        
        //Then
        XCTAssertTrue(networkManager.fetchWeatherCalled)
        XCTAssertTrue(locationManager.locationRetrieveCalled)
        
        XCTAssertEqual(weatherDisplay, expectedWeather)
        
        XCTAssertEqual(UserDefaults.standard.string(forKey: "city"), "Atlanta")
    }
    
    func testWeatherModelInitialization_isSuccess() {
        //Given
        let data = MockParams.data
        
        //When
        let weatherModel = try! JSONDecoder().decode(WeatherResponse.self, from: data)
        
        //Then
        XCTAssertEqual(weatherModel.name, "New York")
        XCTAssertEqual(weatherModel.visibility, 10000)
        XCTAssertEqual(weatherModel.wind, Wind(speed: 3.09))
    }
}
