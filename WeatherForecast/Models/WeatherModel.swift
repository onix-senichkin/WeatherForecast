//
//  WeatherModel.swift
//  WeatherForecast
//
//  Created by Denis Senichkin on 2/11/19.
//  Copyright © 2019 Denis Senichkin. All rights reserved.
//

import Foundation

struct WeatherModel: Decodable {
    
    let weather: [weather]
    let main: main
    let rain: rain?
    let wind: wind
}

struct weather: Decodable {
    
    let main: String
    let description: String
    let icon: String
}

struct main: Decodable {
    
    let temp: Float
    let pressure: Float
    let humidity: Int
}

struct rain: Decodable {
    
    let level1h: Float?
    let level3h: Float?
    
    private enum CodingKeys: String, CodingKey {
        case level1h = "1h"
        case level3h = "3h"
    }
}

struct wind: Decodable {
    
    let speed: Float
    let deg: Float
}

/*
 {
 "coord": {
 "lon": 139.01,
 "lat": 35.02
 },
 "weather": [
 {
 "id": 800,
 "main": "Clear",
 "description": "clear sky",
 "icon": "01n"
 }
 ],
 "base": "stations",
 "main": {
 "temp": 285.514,
 "pressure": 1013.75,
 "humidity": 100,
 "temp_min": 285.514,
 "temp_max": 285.514,
 "sea_level": 1023.22,
 "grnd_level": 1013.75
 },
 "wind": {
 "speed": 5.52,
 "deg": 311
 },
 "clouds": {
 "all": 0
 },
 "dt": 1485792967,
 "sys": {
 "message": 0.0025,
 "country": "JP",
 "sunrise": 1485726240,
 "sunset": 1485763863
 },
 "id": 1907296,
 "name": "Tawarano",
 "cod": 200
 }
 */
