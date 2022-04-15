//
//  ZoneTableViewCell.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik (HLB) on 07/04/2022.
//

import UIKit

class ZoneTableViewCell: UITableViewCell {
    
    @IBOutlet weak var zoneInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(desc: String) {
        zoneInfoLabel.text = desc
    }
    
}
