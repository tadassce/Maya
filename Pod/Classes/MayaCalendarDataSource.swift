//
//  MayaCalendarDataSource.swift
//  Pods
//
//  Created by Ivan Bruel on 01/03/16.
//
//

import UIKit

@objc public protocol MayaCalendarDataSource {

  optional func calendarMonthName(month: MayaMonth) -> String?
  optional func calendarTextColorForDate(date: MayaDate) -> UIColor?
  optional func calendarBackgroundColorForDate(date: MayaDate) -> UIColor?
  optional func calendarFontForDate(date: MayaDate) -> UIFont?
  
}
