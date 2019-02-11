//
//  TodayVC.swift
//  WeatherForecast
//
//  Created by Denis Senichkin on 2/11/19.
//  Copyright © 2019 Denis Senichkin. All rights reserved.
//

import UIKit

class TodayVC: UIViewController {
    
    var viewModel: TodayVMType! {
        didSet {
            viewModel.callback = { [weak self] state in
                self?.parseCallback(state: state)
            }
        }
    }
    
    @IBOutlet weak var ivTopInfo: TodayTopView!
    @IBOutlet weak var ivMediumInfo: TodayInfoView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        refreshWeather()
    }
    

    private func setupUI() {
        ivTopInfo.backgroundColor = .white
        ivMediumInfo.backgroundColor = .white
    }
}

//MARK:- Actions
extension TodayVC {
    
    @IBAction func btnRefreshClicked(_ sender: UIBarButtonItem) {
        refreshWeather()
    }
    
    private func refreshWeather() {
        HUDRenderer.showHUD()
        viewModel.getWeather()
    }
    
    @IBAction func btnShareClicked(_ sender: UIButton) {
        guard let location = viewModel.userLocation else {
            AlertHelper.showAlert("No user location to share")
            return
        }
        
        let url = "http://maps.apple.com/maps?saddr=\(location.latitude),\(location.longitude)"
        let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        if Platform.isIPad {
            activityViewController.popoverPresentationController?.sourceView  = sender
        }
        present(activityViewController, animated: true, completion: nil)
    }
}

//MARK:- Viewmodel Callback state
extension TodayVC {
    
    fileprivate func parseCallback(state: TodayVMState) {
        HUDRenderer.hideHUD()
        switch state {
            case .itemsRecieved(let weather):
                itemReceived(weather)
            case .error(let message):
                errorReceived(errorStr: message)
            default: break
        }
    }
    
    fileprivate func itemReceived(_ weather: WeatherViewModel) {
        ivTopInfo.update(weather: weather)
        ivMediumInfo.update(weather: weather)
    }
    
    fileprivate func errorReceived(errorStr: String) {
        AlertHelper.showAlert(msg: errorStr)
    }
}
