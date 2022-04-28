//
//  NSLayoutConstraint+Extension.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik (HLB) on 27/04/2022.
//
//  Copyright 2022 Shahul Hameed Shaik
//

import UIKit

extension NSLayoutConstraint {

    static func setMultiplier(_ multiplier: CGFloat, of constraint: inout NSLayoutConstraint) {
        NSLayoutConstraint.deactivate([constraint])

        if let firstItem = constraint.firstItem {
            let newConstraint = NSLayoutConstraint(item: firstItem, attribute: constraint.firstAttribute, relatedBy: constraint.relation, toItem: constraint.secondItem, attribute: constraint.secondAttribute, multiplier: multiplier, constant: constraint.constant)

            newConstraint.priority = constraint.priority
            newConstraint.shouldBeArchived = constraint.shouldBeArchived
            newConstraint.identifier = constraint.identifier

            NSLayoutConstraint.activate([newConstraint])
            constraint = newConstraint
        }
    }

}
