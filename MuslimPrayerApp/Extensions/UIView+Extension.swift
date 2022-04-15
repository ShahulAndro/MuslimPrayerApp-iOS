//
//  UIView+Extension.swift
//  MuslimPrayerApp
//
//  Created by Shahul Hamed Shaik (HLB) on 15/04/2022.
//

import Foundation
import UIKit

extension UIView {
    
    func addBorderGradient(startColor: UIColor = UIColor.red, endColor: UIColor = UIColor.blue, lineWidth: CGFloat = 15, startPoint: CGPoint = CGPoint.topLeft, endPoint: CGPoint = CGPoint.bottomRight) {
        //This will make view border circular
        self.layer.cornerRadius = self.bounds.size.height / 2.0
        //This will hide the part outside of border, so that it would look like circle
        self.clipsToBounds = true
        //Create object of CAGradientLayer
        let gradient = CAGradientLayer()
        //Assign origin and size of gradient so that it will fit exactly over circular view
        gradient.frame = self.bounds
        //Pass the gredient colors list to gradient object
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        //Point from where gradient should start
        gradient.startPoint = startPoint
        //Point where gradient should end
        gradient.endPoint = endPoint
        //Now we have to create a circular shape so that it can be added to view’s layer
        let shape = CAShapeLayer()
        //Width of circular line
        shape.lineWidth = lineWidth
        //Create circle with center same as of center of view, with radius equal to half height of view, startAngle is the angle from where circle should start, endAngle is the angle where circular path should end
        shape.path = UIBezierPath(
            arcCenter: CGPoint(x: self.bounds.height/2,
                               y: self.bounds.height/2),
            radius: self.bounds.height/2,
            startAngle: CGFloat(0),
            endAngle:CGFloat(CGFloat.pi * 2),
            clockwise: true).cgPath
        //the color to fill the path’s stroked outline
        shape.strokeColor = UIColor.black.cgColor
        //The color to fill the path
        shape.fillColor = UIColor.clear.cgColor
        //Apply shape to gradient layer, this will create gradient with circular border
        gradient.mask = shape
        //Finally add the gradient layer to out View
        self.layer.addSublayer(gradient)
    }
    
}
