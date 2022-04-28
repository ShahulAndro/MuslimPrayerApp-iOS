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
//  UIView+Extension.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik on 15/04/2022.
//
//  Copyright 2022 Shahul Hameed Shaik
//

import Foundation
import UIKit

extension UIView {
    
    func addBorderGradient(startColor: UIColor = UIColor.red, endColor: UIColor = UIColor.blue, lineWidth: CGFloat = 15, startPoint: CGPoint = CGPoint.topLeft, endPoint: CGPoint = CGPoint.bottomRight) {
        self.layer.cornerRadius = self.bounds.size.height / 2.0
        self.clipsToBounds = true
        
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        
        let shape = CAShapeLayer()
        shape.lineWidth = lineWidth
        shape.path = UIBezierPath(
            arcCenter: CGPoint(x: self.bounds.height/2,y: self.bounds.height/2),
            radius: self.bounds.height/2,
            startAngle: CGFloat(0),
            endAngle:CGFloat(CGFloat.pi * 2),
            clockwise: true).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        
        gradient.mask = shape
        self.layer.addSublayer(gradient)
    }
    
}
