//
//  ForecastVM.swift
//  WeatherForecast
//
//  Created by Denis Senichkin on 2/11/19.
//  Copyright © 2019 Denis Senichkin. All rights reserved.
//

import Foundation

enum ForecastVMState {
    case none
    case itemsRecieved()
    case error(message: String)
}

protocol ForecastVMType {
    
    //actions
    func getForecast()
    
    //callback
    var callback: ((ForecastVMState) -> ())? { get set }
    
    //data source
    func getNumberOfSection() -> Int
    func getNumberOfRow(section: Int) -> Int
    func getItem(section: Int, index: Int) -> ForecastItemViewModel?
}

class ForecastVM: ForecastVMType {
    
    let userLocationService: UserLocationService
    var callback: ((ForecastVMState) -> ())?
    var state: ForecastVMState = .none {
        didSet { callback?(state) }
    }
    
    var items: [ForecastItemViewModel] = []
    var itemsCount: [Int] = []
    
    init(serviceHolder: ServiceHolder) {
        userLocationService = serviceHolder.get(by: UserLocationService.self)
    }
}

//MARK: - Actions
extension ForecastVM {
    
    func getForecast() {
        guard let userLocation = userLocationService.userLocation else {
            state = .error(message: "No user location finded")
            return
        }
        
        let request = GetForecastForLocationRequest(location: userLocation)
        request.getForecast(sBlock: { [weak self] forecast in
            let sorted = forecast.sorted(by: { $0.dt_txt < $1.dt_txt })
            self?.items = sorted.map( { ForecastItemViewModel($0) } )
            self?.prepareData()
        }) { [weak  self] errorStr in
            self?.state = .error(message: errorStr)
        }
    }
}

//MARK: - DataSource
extension ForecastVM {
    
    func prepareData() {
        let allDays = items.compactMap( { $0.date })
        let uniqueDays = Array(Set(allDays)).sorted(by: { $0 < $1 } )
        
        itemsCount = []
        for index in 0..<uniqueDays.count {
            
            let item = uniqueDays[index]
            let filtered = allDays.filter( { $0 == item } )
            itemsCount.append(filtered.count)
        }

        self.state = .itemsRecieved()
    }
    
    func getNumberOfSection() -> Int {
        return itemsCount.count
    }
    
    func getNumberOfRow(section: Int) -> Int {
        if section < itemsCount.count {
            return itemsCount[section]
        }
        
        return 0
    }
    
    func getItem(section: Int, index: Int) -> ForecastItemViewModel? {
        var allCount = 0
        for index in 0..<section {
            let count = getNumberOfRow(section: index)
            allCount += count
        }
        
        let totalIndex = allCount + index
        if totalIndex < items.count {
            return items[totalIndex]
        }
        
        return nil
    }
}
