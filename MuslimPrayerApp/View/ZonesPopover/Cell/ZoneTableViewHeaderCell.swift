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
//  ZoneTableViewHeaderCell.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik on 10/04/2022.
//
//  Copyright 2022 Shahul Hameed Shaik
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
