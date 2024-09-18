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
        let expectation = expectation(description: "Weather mock Data ready")
        let networkManager = MockNetwork()
        let locationManager = MockLocationMap()
        
        let expectedWeather = try! JSONDecoder().decode(WeatherResponse.self, from: MockResponse.data)
        networkManager.weatherToReturn = expectedWeather
        
        let viewModel = WeatherViewModel(networkManager: networkManager,
                                         locationManager: locationManager)
        
        //When
        await viewModel.weatherCity(city: "Atlanta")
        
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            XCTAssertTrue(networkManager.fetchWeatherCalled)
            XCTAssertTrue(locationManager.locationRetrieveCalled)
            
            XCTAssertEqual(viewModel.weatherDisplay, expectedWeather)
            
            XCTAssertEqual(UserDefaults.standard.string(forKey: "city"), "Atlanta")
            expectation.fulfill()
        }
        wait(for: [expectation])
    }

    func testWeatherForCoordinates_isSuccess() async throws {
        //Given
        let expectation = expectation(description: "Weather mock Data ready")
        let networkManager = MockNetwork()
        let locationManager = MockLocationMap()
        
        let expectedWeather = try! JSONDecoder().decode(WeatherResponse.self, from: MockResponse.data)
        networkManager.weatherToReturn = expectedWeather
        
        let viewModel = WeatherViewModel(networkManager: networkManager,
                                  locationManager: locationManager)
        
        //When
        await viewModel.weatherCoordinates(lat: 33.749, lon: -84.388)
        
        //Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            XCTAssertTrue(networkManager.fetchWeatherCalled)
            XCTAssertTrue(locationManager.locationRetrieveCalled)
            
            XCTAssertEqual(viewModel.weatherDisplay, expectedWeather)
            
            XCTAssertEqual(UserDefaults.standard.string(forKey: "city"), "Atlanta")
            expectation.fulfill()
        }
        wait(for: [expectation])
    }
    
    func testWeatherModelInitialization_isSuccess() {
        //Given
        let data = MockResponse.data
        
        //When
        let weatherModel = try! JSONDecoder().decode(WeatherResponse.self, from: data)
        
        //Then
        XCTAssertEqual(weatherModel.name, "Atlanta")
        XCTAssertEqual(weatherModel.visibility, 10000)
        XCTAssertEqual(weatherModel.wind, Wind(speed: 0.45))
    }
}
