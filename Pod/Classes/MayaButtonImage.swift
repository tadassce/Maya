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

    UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)

    //// Color Declarations
    let strokeColor = UIColor.black

    //// Bezier Drawing
    let bezierPath = UIBezierPath()
    bezierPath.move(to: CGPoint(x: 0.77, y: 0.5))
    bezierPath.addLine(to: CGPoint(x: 7.63, y: 7.91))
    bezierPath.addLine(to: CGPoint(x: 0.77, y: 15.34))
    bezierPath.lineCapStyle = .square;

    strokeColor.setStroke()
    bezierPath.lineWidth = 1
    bezierPath.stroke()

    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return image
  }

  static var leftArrowImage: UIImage {
    let bounds = CGRect(x: 0, y: 0, width: 16, height: 16)

    UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)

    let strokeColor2 = UIColor.black

    //// Bezier 2 Drawing
    let bezier2Path = UIBezierPath()
    bezier2Path.move(to: CGPoint(x: 8.13, y: 0.5))
    bezier2Path.addLine(to: CGPoint(x: 1.27, y: 7.91))
    bezier2Path.addLine(to: CGPoint(x: 8.13, y: 15.34))
    bezier2Path.lineCapStyle = .square;

    strokeColor2.setStroke()
    bezier2Path.lineWidth = 1
    bezier2Path.stroke()

    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image
  }

}
