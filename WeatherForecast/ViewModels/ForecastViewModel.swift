//
//  ForecastViewModel.swift
//  WeatherForecast
//
//  Created by Denis Senichkin on 2/11/19.
//  Copyright © 2019 Denis Senichkin. All rights reserved.
//

import Foundation

class ForecastItemViewModel {
    
    private let model: ForecastItem
    
    init(_ model: ForecastItem) {
        self.model = model
    }
    
    var date: String? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: model.dt_txt)
        if let year = components.year, let month = components.month, let day = components.day {
            let value = String(format: "%d%d%d", year, month, day)
            return value
        }
        return nil
    }
    
    //header cell
    var dateString: String? {
        let calendar = Calendar.current
        if calendar.isDateInToday(model.dt_txt) {
            return "TODAY"
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: model.dt_txt).uppercased()
    }
    
    //weather cell
    var time: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        return formatter.string(from: model.dt_txt)
    }
    
    var status: String {
        return model.weather.first?.main ?? "n/a"
    }
    
    var temperature: String {
        return String(format: "%.0f°", model.main.temp)
    }
    
    var imStatusIconURL: URL? {
        guard let iconId = model.weather.first?.icon else { return nil }
        let path = Defines.imagesURL + iconId + ".png"
        return URL(string: path)
    }
}
