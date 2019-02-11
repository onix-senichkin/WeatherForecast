//
//  TodayTopView.swift
//  WeatherForecast
//
//  Created by Denis Senichkin on 2/11/19.
//  Copyright © 2019 Denis Senichkin. All rights reserved.
//

import UIKit
import AlamofireImage

class TodayTopView: UIView {

    @IBOutlet weak var imStatus: UIImageView!
    @IBOutlet weak var lbLocation: UILabel!
    @IBOutlet weak var lbTempState: UILabel!
    
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
        imStatus.image = nil
        lbLocation.text = "--"
        lbTempState.text = "--"
    }
    
    func update(weather: WeatherViewModel) {
        self.lbLocation.text = weather.userLocationInfo ?? "n/a"
        self.lbTempState.text = weather.tempAndState
        self.imStatus.image = nil
        if let url = weather.imStatusIconURL {
            self.imStatus.af_setImage(withURL: url)
        }
    }

}
