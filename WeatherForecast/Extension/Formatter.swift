//
//  Formatter.swift
//  WeatherForecast
//
//  Created by Denis Senichkin on 2/11/19.
//  Copyright © 2019 Denis Senichkin. All rights reserved.
//

import Foundation

extension Formatter {
    
    struct Date {
        static let iso8601Full: DateFormatter = {
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.locale = Locale.current
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return formatter
        }()
    }
}

extension Date {
    
    var iso8601Full: String {
        return Formatter.Date.iso8601Full.string(from: self)
    }
}

extension String {
    var iso8601Full: Date? {
        return Formatter.Date.iso8601Full.date(from: self)
    }
}
