//
//  WeatherCell.swift
//  WeatherForecast
//
//  Created by Denis Senichkin on 2/11/19.
//  Copyright © 2019 Denis Senichkin. All rights reserved.
//

import UIKit
import AlamofireImage

class WeatherCell: UITableViewCell {

    @IBOutlet weak var imStatus: UIImageView!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbTemp: UILabel!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var ivSeparator: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        lbTime.text = "--"
        lbTemp.text = "--"
        lbStatus.text = "--"
        imStatus.image = nil
    }

    func update(_ model: ForecastItemViewModel, first: Bool, last: Bool) {
        lbTime.text = model.time
        lbStatus.text = model.status
        lbTemp.text = model.temperature
        imStatus.image = nil
        if let url = model.imStatusIconURL {
            self.imStatus.af_setImage(withURL: url)
        }
        
        if first {
            borderView.layer.borderColor = UIColor(displayP3Red: 49/255.0, green: 111/255.0, blue: 182/255.0, alpha: 1.0).cgColor
            borderView.layer.borderWidth = 2
            ivSeparator.isHidden = true
        } else {
            borderView.layer.borderColor = nil
            borderView.layer.borderWidth = 0
            ivSeparator.isHidden = false
        }
        
        if last {
            ivSeparator.isHidden = true
        }
    }
}
