//
//  GetWeatherForLocation.swift
//  WeatherForecast
//
//  Created by Denis Senichkin on 2/11/19.
//  Copyright © 2019 Denis Senichkin. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

//https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22

class GetWeatherForLocationRequest: BaseRequest {
    
    private var location: CLLocationCoordinate2D
    
    init(location: CLLocationCoordinate2D) {
        self.location = location
    }
    
    deinit {
        print("GetWeatherForLocationRequest deinit")
    }
    
    /*override func mockDataName() -> String? {
        return "GetWeatherForLocation"
    }*/
    
    override func apiPath() -> String? {
        let path = Defines.serverURL + "weather"
        return path
    }
    
    override func parameters() -> [String : Any]? {
        let params:[String : Any] = ["lat" : location.latitude,
                                     "lon" : location.longitude,
                                     "appid" : Defines.kApiKey,
                                     "units" : "metric"]
        return params
    }
    
    override func method() -> HTTPMethod {
        return .get
    }
}

//MARK: - Get data
extension GetWeatherForLocationRequest {
    
    func getWeather(sBlock: @escaping SimpleClosure<WeatherModel>, eBlock: @escaping SimpleClosure<String>) {
        
        performRequest(to: WeatherModel.self) { response in
            switch response {
            case .success(let responseObject):
                if let item = responseObject as? WeatherModel {
                    sBlock(item)
                } else {
                    eBlock(parseErrorString)
                }
            case .error(let error):
                eBlock(error)
            }
        }
    }
}
