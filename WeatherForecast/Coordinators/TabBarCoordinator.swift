//
//  TabBarCoordinator.swift
//  WeatherForecast
//
//  Created by Denis Senichkin on 2/11/19.
//  Copyright © 2019 Denis Senichkin. All rights reserved.
//

import UIKit

enum TabBarItems: Int {
    case tabToday = 0
    case tabForecast
}

protocol TabBarCoordinatorTransitions: class {
    
}

class TabBarCoordinator {
    
    private weak var window: UIWindow?
    private weak var transitions: TabBarCoordinatorTransitions?
    private let serviceHolder: ServiceHolder

    private let tabBarController = UITabBarController()
    
    init(window: UIWindow, serviceHolder: ServiceHolder, transitions: TabBarCoordinatorTransitions?) {
        self.window = window
        self.serviceHolder = serviceHolder
        self.transitions = transitions
        
        tabBarController.tabBar.barTintColor = .white
        initTabItems()
    }
    
    private func initTabItems() {
        
        //simple init, should be moved to coordinators or fabric on more complex projects
        let sb = UIStoryboard(name: "Main", bundle: nil)

        //today init
        let todayVC = sb.instantiateViewController(withIdentifier: "TodayVC") as? TodayVC
        todayVC?.viewModel = TodayVM(serviceHolder: serviceHolder)

        let todayTabBarItem = UITabBarItem(title: "Today", image: UIImage(named: "tabToday"), selectedImage: nil)
        let todayNav = initSimpleNavigation(todayTabBarItem)
        
        //forecast init
        let forecastVC = sb.instantiateViewController(withIdentifier: "ForecastVC") as? ForecastVC
        forecastVC?.viewModel = ForecastVM(serviceHolder: serviceHolder)

        let forecastTabBarItem = UITabBarItem(title: "Forecast", image: UIImage(named: "tabForecast"), selectedImage: nil)
        let forecastNav = initSimpleNavigation(forecastTabBarItem)
        
        if let first = todayVC, let second = forecastVC {
            todayNav.viewControllers = [first]
            forecastNav.viewControllers = [second]
            tabBarController.viewControllers = [todayNav, forecastNav]
        }
    }
    
    private func initSimpleNavigation(_ tabBarItem: UITabBarItem) -> UINavigationController {
        let simpleNav = UINavigationController()
        simpleNav.navigationBar.isTranslucent = false
        simpleNav.navigationBar.barTintColor = .white
        simpleNav.navigationBar.shadowImage = UIImage(named: "navBarShadow")
        simpleNav.tabBarItem = tabBarItem
        return simpleNav
    }
    
    deinit {
        print("TabBarCoordinator deinit")
    }
    
    func start(animated: Bool = false) {
        guard let window = window else { return }

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
