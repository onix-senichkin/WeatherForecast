//
//  ForecastModel.swift
//  WeatherForecast
//
//  Created by Denis Senichkin on 2/11/19.
//  Copyright © 2019 Denis Senichkin. All rights reserved.
//

import Foundation

class ForecastModel: Decodable {
    
    let list: [ForecastItem]
}

class ForecastItem: Decodable {
    let main: main
    let weather: [weather]
    let dt_txt: Date
}

/*
 {"city":{"id":1851632,"name":"Shuzenji",
 "coord":{"lon":138.933334,"lat":34.966671},
 "country":"JP",
 "cod":"200",
 "message":0.0045,
 "cnt":38,
 "list":[{
 "dt":1406106000,
 "main":{
 "temp":298.77,
 "temp_min":298.77,
 "temp_max":298.774,
 "pressure":1005.93,
 "sea_level":1018.18,
 "grnd_level":1005.93,
 "humidity":87,
 "temp_kf":0.26},
 "weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],
 "clouds":{"all":88},
 "wind":{"speed":5.71,"deg":229.501},
 "sys":{"pod":"d"},
 "dt_txt":"2014-07-23 09:00:00"}
 ]}
 */
