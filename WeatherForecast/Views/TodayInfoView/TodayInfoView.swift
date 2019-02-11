//
//  TodayInfoView.swift
//  WeatherForecast
//
//  Created by Denis Senichkin on 2/11/19.
//  Copyright © 2019 Denis Senichkin. All rights reserved.
//

import UIKit

class TodayInfoView: UIView {

    @IBOutlet weak var lbWet: UILabel!
    @IBOutlet weak var lbRain: UILabel!
    @IBOutlet weak var lbPressure: UILabel!
    @IBOutlet weak var lbWind: UILabel!
    @IBOutlet weak var lbWindDirection: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    private func customInit() {
        self.nibSetup() //load xib
        
        self.backgroundColor = .white
        lbWet.text = "--"
        lbRain.text = "--"
        lbPressure.text = "--"
        lbWind.text = "--"
        lbWindDirection.text = "--"
    }
    
    func update(weather: WeatherViewModel) {
        lbWet.text = weather.humidity
        lbRain.text = weather.rainLevel
        lbPressure.text = weather.pressure
        
        lbWind.text = weather.windSpeed
        lbWindDirection.text = weather.windDirection
        
    }
}
