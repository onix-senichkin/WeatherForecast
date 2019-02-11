//
//  AppCoordinator.swift
//  WeatherForecast
//
//  Created by Denis Senichkin on 2/11/19.
//  Copyright © 2019 Denis Senichkin. All rights reserved.
//

import UIKit
import Firebase

class AppCoordinator {
    
    private let window: UIWindow
    private let serviceHolder = ServiceHolder()

    private var tabBarCoordinator: TabBarCoordinator?
    
    init(window: UIWindow) {
        self.window = window
        start()
    }
    
    private func start() {
        startServices()
        enterApp()
    }
    
    private func enterApp() {
        tabBarCoordinator = TabBarCoordinator(window: window, serviceHolder: serviceHolder, transitions: nil)
        tabBarCoordinator?.start()
    }
    
    deinit {
        print("AppCoordinator - deinit")
    }
}

//MARK:- Services routine
extension AppCoordinator {
    
    private func startServices() {
        //firebase
        FirebaseApp.configure()

        let userLocationService = UserLocationService()
        let firebaseService = FirebaseService()
        
        serviceHolder.add(UserLocationService.self, for: userLocationService)
        serviceHolder.add(FirebaseService.self, for: firebaseService)
    }

}



