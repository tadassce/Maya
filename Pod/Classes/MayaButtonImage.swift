//
//  MayaButtonImage.swift
//  Pods
//
//  Created by Ivan Bruel on 04/03/16.
//
//

import Foundation
import UIKit

class MayaButtonImage {

  static var rightArrowImage: UIImage {
    let bounds = CGRect(x: 0, y: 0, width: 16, height: 16)

    UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.mainScreen().scale)

    //// Color Declarations
    let strokeColor = UIColor.blackColor()

    //// Bezier Drawing
    let bezierPath = UIBezierPath()
    bezierPath.moveToPoint(CGPointMake(0.77, 0.5))
    bezierPath.addLineToPoint(CGPointMake(7.63, 7.91))
    bezierPath.addLineToPoint(CGPointMake(0.77, 15.34))
    bezierPath.lineCapStyle = .Square;

    strokeColor.setStroke()
    bezierPath.lineWidth = 1
    bezierPath.stroke()

    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return image
  }

  static var leftArrowImage: UIImage {
    let bounds = CGRect(x: 0, y: 0, width: 16, height: 16)

    UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.mainScreen().scale)

    let strokeColor2 = UIColor.blackColor()

    //// Bezier 2 Drawing
    let bezier2Path = UIBezierPath()
    bezier2Path.moveToPoint(CGPointMake(8.13, 0.5))
    bezier2Path.addLineToPoint(CGPointMake(1.27, 7.91))
    bezier2Path.addLineToPoint(CGPointMake(8.13, 15.34))
    bezier2Path.lineCapStyle = .Square;

    strokeColor2.setStroke()
    bezier2Path.lineWidth = 1
    bezier2Path.stroke()

    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image
  }

}