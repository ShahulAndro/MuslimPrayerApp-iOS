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
//  Date+Extension.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik on 12/04/2022.
//

import Foundation

extension Date {
    
    var dayAfter: Date {
        var dateComponent = DateComponents()
        dateComponent.day = 1
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: self)!
        return futureDate
    }
    
    var dayBefore: Date {
        var dateComponent = DateComponents()
        dateComponent.day = -1
        let pastDate = Calendar.current.date(byAdding: dateComponent, to: self)!
        return pastDate
    }
    
    var dateStringddMMMyyy: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        let date = dateFormatter.string(from: Date())
        return date
    }
    
}
