//
//  HUDRenderer.swift
//  WeatherForecast
//
//  Created by Denis Senichkin on 2/11/19.
//  Copyright © 2019 Denis Senichkin. All rights reserved.
//

import Foundation
import MBProgressHUD

class HUDRenderer {
    
    class func showHUD() {
        DispatchQueue.main.async {
            guard let view = UIApplication.shared.keyWindow else { return }
            MBProgressHUD.hide(for: view, animated: false)
            MBProgressHUD.showAdded(to: view, animated: true)
        }
    }
    
    class func hideHUD() {
        DispatchQueue.main.async {
            guard let view = UIApplication.shared.keyWindow else { return }
            MBProgressHUD.hide(for: view, animated: true)
        }
    }
}
