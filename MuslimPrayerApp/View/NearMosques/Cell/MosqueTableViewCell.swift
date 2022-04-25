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
//  MosqueTableViewCell.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik on 12/04/2022.
//

import UIKit
import Kingfisher

class MosqueTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rootCellView: UIView!
    @IBOutlet weak var masjidImageView: UIImageView!
    
    @IBOutlet weak var masjidNameLabel: UILabel!
    @IBOutlet weak var latitudeLongitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var telephoneLabel: UILabel!
    @IBOutlet weak var faxLabel: UILabel!
    @IBOutlet weak var openMapButton: UIButton!
    @IBOutlet weak var distanceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        rootCellView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        rootCellView.layer.cornerRadius = 10
        
        openMapButton.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 15)
        openMapButton.setTitleColor(.orange, for: [.selected,.highlighted])
        
        selectionStyle = .none
        
        masjidImageView.isHidden = true
    }
    
    @IBAction func tapOnOpenMapButton(_ sender: Any) {
        print("tapOnOpenMapButton")
    }
    
    func updateCell(location: LocationData) {
//        let masjidImagePath = "\(Utils.masjidImagesBaseUrl)\(location.img_name ?? "")"
//        let imageURL = URL(string: masjidImagePath)
//        masjidImageView.kf.setImage(with: imageURL)
        
        masjidNameLabel.text = location.nama_masjid ?? ""
        latitudeLongitudeLabel.text = "Latitude: \(location.latitud ?? "") | Longitude: \(location.longitud ?? "")"
        addressLabel.text = "Address:\n\(location.alamat ?? "")"
        if let telephone = location.tel, !telephone.isEmpty {
            telephoneLabel.isHidden = false
            telephoneLabel.text = "Tel: \(telephone)"
        } else {
            telephoneLabel.isHidden = true
        }
        
        if let fax = location.fax, !fax.isEmpty {
            faxLabel.isHidden = false
            faxLabel.text = "Fax: \(fax)"
        } else {
            faxLabel.isHidden = true
        }
        distanceLabel.text = "Distance: \(location.distance) kms"
    }
}
