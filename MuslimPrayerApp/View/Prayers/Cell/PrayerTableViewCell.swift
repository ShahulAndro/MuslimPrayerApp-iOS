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
//  PrayerTableViewCell.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik on 11/04/2022.
//

import UIKit

class PrayerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var prayerTypeLabel: UILabel!
    @IBOutlet weak var prayerTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        prayerTypeLabel.accessibilityIdentifier = "prayerTypeLabel"
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
