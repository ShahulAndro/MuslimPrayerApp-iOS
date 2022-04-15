//
//  MosqueTableViewCell.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik (HLB) on 12/04/2022.
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
        distanceLabel.text = "Distance: \(location.distance)kms"
    }
}
