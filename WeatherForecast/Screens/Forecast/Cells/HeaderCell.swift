//
//  HeaderCell.swift
//  WeatherForecast
//
//  Created by Denis Senichkin on 2/11/19.
//  Copyright © 2019 Denis Senichkin. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell {

    @IBOutlet weak var lbDay: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lbDay.text = "--"
    }
    
    func update(_ model: ForecastItemViewModel) {
        lbDay.text = model.dateString
    }

}
