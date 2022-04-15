//
//  NearMosquesViewController.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik (HLB) on 06/04/2022.
//

import UIKit
import CoreLocation
import RxSwift

class NearMosquesViewController: UIViewController {
    
    @IBOutlet weak var mosquesTableView: UITableView!
    
    private let locationManager = CLLocationManager()
    private let viewModel = ESolatViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCommon()
        setupBindings()
    }

}


//MARK: - init common

extension NearMosquesViewController {
    
    private func initCommon() {
        mosquesTableView.backgroundColor = UIColor(hexString: "#212121").withAlphaComponent(0.5)
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
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
        
        
//        mosquesTableView.rx
//            .setDelegate(self)
//            .disposed(by: disposeBag)
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
            viewModel.fetchNearestMosques(lat: String(location.coordinate.latitude), long: String(location.coordinate.longitude))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //TODO: show location error or alert
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if #available(iOS 13.4, *) {
            if status == .authorizedWhenInUse {
                self.locationManager.requestAlwaysAuthorization()
            }
            self.locationManager.requestWhenInUseAuthorization()
        } else {
            self.locationManager.requestAlwaysAuthorization()
        }
    }
    
}

extension NearMosquesViewController {
    
    func setupBindings() {
        viewModel
            .locationData
            .bind(to: mosquesTableView.rx.items(cellIdentifier: "mosqueCell", cellType: MosqueTableViewCell.self)) { (row, locationData, cell) in
                cell.updateCell(location: locationData)
            }.disposed(by: disposeBag)
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
