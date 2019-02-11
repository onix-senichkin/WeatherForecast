//
//  UserLocationService.swift
//  WeatherForecast
//
//  Created by Denis Senichkin on 2/11/19.
//  Copyright © 2019 Denis Senichkin. All rights reserved.
//

import Foundation
import CoreLocation

protocol UserLocationServiceType: Service {
    
    //callback
    var callBackUserAddressWasChanged: SimpleClosure<String>? { get set }
    
    //getters
    var userLocation: CLLocationCoordinate2D? { get }
    var userAddress: String? { get }
    
}

class UserLocationService: NSObject, UserLocationServiceType {

    private var locationManager: CLLocationManager?
    private var lastUserLocation: CLLocationCoordinate2D?
    private var lastUserAddress: String?

    var callBackUserAddressWasChanged: SimpleClosure<String>?
    
    override init() {
        super.init()
        
        locationManager = CLLocationManager()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.distanceFilter =  kCLDistanceFilterNone
        locationManager?.delegate = self
        
        let status = CLLocationManager.authorizationStatus()
        if status == .notDetermined {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                self?.locationManager?.requestWhenInUseAuthorization()
            }
        } else if status != .denied && status != .restricted {
            locationManager?.startUpdatingLocation()
        }
    }
    
    deinit {
        print("UserLocationService deinit")
    }
}

//MARK:- Getters
extension UserLocationService {
    
    var userLocation: CLLocationCoordinate2D? {
        return lastUserLocation
    }
    
    var userAddress: String? {
        return lastUserAddress ?? "n/a"
    }
}

//MARK:- CLLocationManagerDelegate
extension UserLocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager?.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print("locationManager didUpdateLocations to \(String(describing: locations.last))")
        
        //lastUserLocation = locations.last?.coordinate
        updateUserAddress(locations.last)
        
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //AlertHelper.showAlert(msg: error.localizedDescription)
        AlertHelper.showAlert(msg: "Can't find user location")
    }
    
    private func getDistance(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> Double {
        
        let coordinateFrom = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let coordinateTo = CLLocation(latitude: to.latitude, longitude: to.longitude)
        let distance = coordinateFrom.distance(from: coordinateTo)
        return distance
    }
}

//MARK:- Address routine
extension UserLocationService {
    
    private func updateUserAddress(_ location: CLLocation?) {
        guard let location = location else { return }
        
        //check for distance changes, if less than defined, don't call delegate
        if let userLocation = userLocation {
            let distanceFromLastLocation = getDistance(from: location.coordinate, to: userLocation)
            if distanceFromLastLocation < Defines.locationDistanceUpdate {
                return
            }
        }
        
        lastUserLocation = location.coordinate

        CLGeocoder().reverseGeocodeLocation(location) { [weak self] (places, error) in
            if let place = places?.first {
                if let address = self?.makeAddressString(place: place) {
                    self?.lastUserAddress = address
                    self?.callBackUserAddressWasChanged?(address)
                    //print("reverseGeocodeLocation address \(address)")
                }
            }
        }
    }
    
    private func makeAddressString(place: CLPlacemark) -> String {
        let items = [place.locality, place.country,].compactMap( { $0 })
        let address = items.joined(separator: ", ")
        return address
    }
}
