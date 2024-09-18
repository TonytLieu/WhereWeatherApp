//
//  LocationMap.swift
//  WhereWeatherApp
//
//  Created by Tony Lieu on 9/17/24.
//


import Foundation
import CoreLocation

protocol LocationManagerProtocol {
    func locationFailed()
    func locationUpdated(lat: Double, lon: Double)
}

protocol LocationMapService {
    var delegate: LocationManagerProtocol? { set get }
    func locationRetrieve()
}

class LocationManager: NSObject, LocationMapService, CLLocationManagerDelegate {
    var delegate: LocationManagerProtocol?
    let cllManager = CLLocationManager()
    
    override init() {
        super.init()
        locationRetrieve()
    }
    
    func locationRetrieve() {
        cllManager.delegate = self
        cllManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.delegate?.locationUpdated(lat: location.coordinate.latitude,
                                          lon: location.coordinate.longitude)
        } else {
            self.delegate?.locationFailed()
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch cllManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse, .notDetermined:
            self.cllManager.requestLocation()
        default:
            self.delegate?.locationFailed()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.delegate?.locationFailed()
        print(error.localizedDescription)
    }
    
}
