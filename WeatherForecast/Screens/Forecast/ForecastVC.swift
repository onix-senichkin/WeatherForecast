//
//  ForecastVC.swift
//  WeatherForecast
//
//  Created by Denis Senichkin on 2/11/19.
//  Copyright © 2019 Denis Senichkin. All rights reserved.
//

import UIKit

class ForecastVC: UIViewController {

    var viewModel: ForecastVMType! {
        didSet {
            viewModel.callback = { [weak self] state in
                self?.parseCallback(state: state)
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getForecast()
    }
    
    
    @IBAction func btnRefreshClicked(_ sender: UIBarButtonItem) {
        getForecast()
    }
    
    private func getForecast() {
        HUDRenderer.showHUD()
        viewModel.getForecast()
    }
}

//MARK:- Viewmodel Callback state
extension ForecastVC {
    
    fileprivate func parseCallback(state: ForecastVMState) {
        HUDRenderer.hideHUD()
        switch state {
            case .itemsRecieved():
                itemReceived()
            case .error(let message):
                errorReceived(errorStr: message)
            default: break
        }
    }
    
    fileprivate func itemReceived() {
        tableView.reloadData()
    }
    
    fileprivate func errorReceived(errorStr: String) {
        AlertHelper.showAlert(msg: errorStr)
    }
}

//MARK:- DataSource
extension ForecastVC: UITableViewDataSource {


    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getNumberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRow(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCell.identifier) as? WeatherCell
        if let item = viewModel.getItem(section: indexPath.section, index: indexPath.row) {
            let first = (indexPath.section == 0 && indexPath.row == 0)
            let totalInSection = viewModel.getNumberOfRow(section: indexPath.section)
            let last = (indexPath.row == totalInSection - 1)
            cell?.update(item, first: first, last: last)
        }
        return cell ?? UITableViewCell()
    }
    
}

extension ForecastVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeaderCell.identifier) as? HeaderCell
        if let item = viewModel.getItem(section: section, index: 0) {
            cell?.update(item)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
}
