//
//  MayaDelegate.swift
//  Pods
//
//  Created by Ivan Bruel on 01/03/16.
//
//

import UIKit

@objc public protocol MayaCalendarDelegate {

  optional func calendarDidSelectDate(date: MayaDate)
  optional func calendarDidChangeMonth(month: MayaMonth)
  
}
