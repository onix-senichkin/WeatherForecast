//
//  Defines.swift
//  WeatherForecast
//
//  Created by Denis Senichkin on 2/11/19.
//  Copyright © 2019 Denis Senichkin. All rights reserved.
//

import Foundation
import UIKit

typealias EmptyClosureType = () -> ()
typealias SimpleClosure<T> = (T) -> ()

struct Defines {
    
    static let serverURL = "https://api.openweathermap.org/data/2.5/"
    static let imagesURL = "https://openweathermap.org/img/w/"
    static let kApiKey = "8d4199f5762dcb6c75991bdffbc32106"
    
    static let locationDistanceUpdate:Double = 10000
}

struct Platform {
    
    static var isSimulator: Bool {
        return TARGET_IPHONE_SIMULATOR != 0 // simulator
    }
    
    static var isIPad: Bool {
        return UIScreen.main.traitCollection.userInterfaceIdiom == .pad
    }
    
    static var isIphone5Size: Bool {
        return UIScreen.main.nativeBounds.width == 640.0
    }
    
    static var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height
    }
    
    static var deviceOrientation: UIInterfaceOrientation {
        if let orientation = UIInterfaceOrientation(rawValue: UIApplication.shared.statusBarOrientation.rawValue) {
            return orientation
        }
        return .portrait
    }
}

