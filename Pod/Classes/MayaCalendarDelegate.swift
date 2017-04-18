//
//  MayaDelegate.swift
//  Pods
//
//  Created by Ivan Bruel on 01/03/16.
//
//

import UIKit

@objc public protocol MayaCalendarDelegate {

  @objc optional func calendarDidSelectDate(_ date: MayaDate)
  @objc optional func calendarDidChangeMonth(_ month: MayaMonth)
  
}
