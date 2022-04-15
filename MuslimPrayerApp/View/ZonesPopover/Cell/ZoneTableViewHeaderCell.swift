//
//  ZoneTableViewHeaderCell.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik (HLB) on 10/04/2022.
//

import UIKit

class ZoneTableViewHeaderCell: UITableViewHeaderFooterView {
    
    @IBOutlet weak var zoneSectionTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateSection(title: String) {
        zoneSectionTitle.text = title
    }

}
