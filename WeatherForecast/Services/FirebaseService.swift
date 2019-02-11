//
//  FirebaseService.swift
//  WeatherForecast
//
//  Created by Denis Senichkin on 2/11/19.
//  Copyright © 2019 Denis Senichkin. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import CoreLocation

private let kKey = "udid.stored"

class FirebaseService: NSObject, Service {
    
    func update(userLocation: CLLocationCoordinate2D, temp: Float) {
        
        let userUID = appUUID()
        
        let value: [String : Any] = ["lat" : userLocation.latitude,
                                     "lon" : userLocation.longitude,
                                     "temp" : temp]
        
        let ref = Database.database().reference()
        ref.child("Info").child(userUID).setValue(value)
    }
    
    private func generateUUID() -> String {
        let uuid = NSUUID().uuidString
        return uuid
    }
    
    private func appUUID() -> String {
        if let key = UserDefaults.standard.object(forKey: kKey) as? String {
            return key
        }
        
        let newKey = generateUUID()
        UserDefaults.standard.set(newKey, forKey: kKey)
        return newKey
    }
}
