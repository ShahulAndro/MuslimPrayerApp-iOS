//
//  Date+Extension.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik (HLB) on 12/04/2022.
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
    
}
