//
//  PrayerTableViewCell.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik (HLB) on 11/04/2022.
//

import UIKit

class PrayerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var prayerTypeLabel: UILabel!
    @IBOutlet weak var prayerTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        prayerTypeLabel.textColor = UIColor(hexString: "#FCB314")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(prayerType: String, prayerTime: String) {
        prayerTypeLabel.text = prayerType
        prayerTimeLabel.text = prayerTime
    }
    
}
