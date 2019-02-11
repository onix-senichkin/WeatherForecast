//
//  WeatherViewModel.swift
//  WeatherForecast
//
//  Created by Denis Senichkin on 2/11/19.
//  Copyright © 2019 Denis Senichkin. All rights reserved.
//

import Foundation

class WeatherViewModel {
    
    private let model: WeatherModel
    
    init(_ model: WeatherModel) {
        self.model = model
    }

    var temperature: Float {
        return model.main.temp
    }
    
    //top info
    var userLocationInfo: String?
    
    var tempAndState: String {
        let desc = model.weather.first?.main ?? "n/a"
        let value = String(format: "%.0f°C  |  %@", model.main.temp, desc)
        return value
    }
    
    var imStatusIconURL: URL? {
        guard let iconId = model.weather.first?.icon else { return nil }
        let path = Defines.imagesURL + iconId + ".png"
        return URL(string: path)
    }
    
    //medium info
    var humidity: String {
        if model.main.humidity > 0 {
            let string = String(format: "%d%%", model.main.humidity)
            return string
        }
        return "n/a"
    }
    
    var rainLevel: String {
        if let rain = model.rain {
            if let rainLevel = rain.level1h {
                let string = String(format: "%.1f mm", rainLevel)
                return string
            }
            
            if let rainLevel = rain.level3h {
                let string = String(format: "%.1f mm", rainLevel)
                return string
            }
        }
        
        return "n/a"
    }
    
    var pressure: String {
        let string = String(format: "%.0f hPa", model.main.pressure)
        return string
    }

    var windSpeed: String {
        let string = String(format: "%.0f km/h", model.wind.speed)
        return string
    }
    
    
    var windDirection: String? {
        let degree = model.wind.deg
        let types = ["N", "NE", "E", "SE", "S", "SW", "W", "NW", "N"]
        let borders:[Float] = [0, 45, 90, 135, 180, 225, 270, 315, 360]
        let differ:Float = 22
        
        for index in 0..<borders.count {
            
            let curValue = borders[index]
            if abs(curValue-degree) < differ, index < types.count {
                return types[index]
            }
        }
        
        return "n/a"
    }
}
