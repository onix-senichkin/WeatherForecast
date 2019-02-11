//
//  TodayVM.swift
//  WeatherForecast
//
//  Created by Denis Senichkin on 2/11/19.
//  Copyright © 2019 Denis Senichkin. All rights reserved.
//

import Foundation
import CoreLocation

enum TodayVMState {
    case none
    case itemsRecieved(weather: WeatherViewModel)
    case error(message: String)
}

protocol TodayVMType {
    
    //callback
    var callback: ((TodayVMState) -> ())? { get set }
    
    //actions
    func getWeather()
    
    //getters
    var userLocation: CLLocationCoordinate2D? { get }
}

class TodayVM: TodayVMType {
    
    let userLocationService: UserLocationService
    let firebaseService: FirebaseService
    var weather: WeatherViewModel?
    
    init(serviceHolder: ServiceHolder) {
        userLocationService = serviceHolder.get(by: UserLocationService.self)
        firebaseService = serviceHolder.get(by: FirebaseService.self)
        
        userLocationService.callBackUserAddressWasChanged = { [weak self] _ in
            self?.userLocationWasChanged()
        }
    }
    
    var callback: ((TodayVMState) -> ())?
    var state: TodayVMState = .none {
        didSet { callback?(state) }
    }
    
    //getters
    var userLocation: CLLocationCoordinate2D? {
        return userLocationService.userLocation
    }
}

//MARK: - Actions
extension TodayVM {
    
    func getWeather() {
        guard let userLocation = userLocationService.userLocation else { return }
        
        let request = GetWeatherForLocationRequest(location: userLocation)
        request.getWeather(sBlock: { [weak self] model in
            let viewModel = WeatherViewModel(model)
            viewModel.userLocationInfo = self?.userLocationService.userAddress ?? "n/a"
            self?.weather = viewModel
            self?.state = .itemsRecieved(weather: viewModel)
            self?.updateFirebaseInfo()
        }) { [weak  self] errorStr in
            self?.state = .error(message: errorStr)
        }
    }
}

//MARK: - User location
extension TodayVM {
    
    func userLocationWasChanged() {
        getWeather()
    }
    
    func updateFirebaseInfo() {
        guard let userLocation = userLocationService.userLocation, let weather = weather else { return }
        
        let temp = weather.temperature
        firebaseService.update(userLocation: userLocation, temp: temp)
    }
    
}
