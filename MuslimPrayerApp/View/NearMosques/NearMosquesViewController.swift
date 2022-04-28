/*
 * Copyright 2022 Shahul Hameed Shaik
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

//
//  NearMosquesViewController.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik on 06/04/2022.
//
//  Copyright 2022 Shahul Hameed Shaik
//

import UIKit
import CoreLocation
import RxSwift

class NearMosquesViewController: UIViewController {
    
    @IBOutlet weak var mosquesTableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var messageLabel: UILabel!
    
    private let locationManager = CLLocationManager()
    private let disposeBag = DisposeBag()
    
    var viewModel: ESolatViewModel!
    weak var coordinator: NearMosquesViewCoordinator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCommon()
        setAccessvilityIdentifierForUITesting()
        setupBindings()
    }

}


//MARK: - init common

extension NearMosquesViewController {
    
    private func initCommon() {
        activityIndicatorView.isHidden = true
        mosquesTableView.backgroundColor = UIColor(hexString: "#212121").withAlphaComponent(0.5)
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManagerDidChangeAuthorization(status: locationAuthorizationStatus())
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        setupTableView()
    }
    
    private func setupTableView() {
        mosquesTableView.register(UINib(nibName: "MosqueTableViewCell", bundle: nil), forCellReuseIdentifier: "mosqueCell")
        mosquesTableView.rowHeight = UITableView.automaticDimension
        mosquesTableView.estimatedRowHeight = 120
        mosquesTableView.separatorStyle = .none
    }
    
    private func showLocationUpdateAuthorisationStatusMessage() {
        mosquesTableView.isHidden = true
        activityIndicatorView.isHidden = false
        messageLabel.isHidden = false
        messageLabel.text = "Location services are not enabled\nPlease update location settings to see Near Mosques"
    }
    
    private func hideLocationUpdateAuthorisationStatusMessage() {
        mosquesTableView.isHidden = false
        messageLabel.isHidden = true
    }
    
    private func locationManagerDidChangeAuthorization(status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways , .authorizedWhenInUse:
            locationManager.requestLocation()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestAlwaysAuthorization()
        case .denied , .restricted:
            showLocationUpdateAuthorisationStatusMessage()
        default:
            print("Default")
        }
    }
    
    private func locationAuthorizationStatus() -> CLAuthorizationStatus {
        var locationAuthorizationStatus : CLAuthorizationStatus
        if #available(iOS 14.0, *) {
            locationAuthorizationStatus =  locationManager.authorizationStatus
        } else {
            locationAuthorizationStatus = CLLocationManager.authorizationStatus()
        }
        return locationAuthorizationStatus
    }
}

extension NearMosquesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
}

extension NearMosquesViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            
            activityIndicatorView.isHidden = false
            activityIndicatorView.startAnimating()
            viewModel.fetchNearestMosques(lat: String(location.coordinate.latitude), long: String(location.coordinate.longitude))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as? CLError, error.code == .denied {
            locationManager.stopMonitoringSignificantLocationChanges()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationManagerDidChangeAuthorization(status: status)
    }
    
}

extension NearMosquesViewController {
    
    func setupBindings() {
        viewModel
            .locationData
            .bind(to: mosquesTableView.rx.items(cellIdentifier: "mosqueCell", cellType: MosqueTableViewCell.self)) { (row, locationData, cell) in
                cell.updateCell(location: locationData)
            }.disposed(by: disposeBag)
        
        viewModel
            .loadingIndicatorPublish
            .bind(onNext: { [weak self] (hide) in
                self?.activityIndicatorView.isHidden = true
                self?.activityIndicatorView.stopAnimating()
                self?.hideLocationUpdateAuthorisationStatusMessage()
            })
            .disposed(by: disposeBag)
    }
    
    func checkAndRequestLocationAuthrosiationIfRequired() {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined, .restricted, .denied:
            Utils.showAlertForRequestSettings(vc: self)
            break
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
            break
        default:
            locationManager.requestAlwaysAuthorization()
        }
    }
    
}


//MARK: - Set AccessibilityIdentifierfor UITesting

extension NearMosquesViewController {
    
    func setAccessvilityIdentifierForUITesting() {
        mosquesTableView.accessibilityIdentifier = "mosquesTableView"
    }
    
}
