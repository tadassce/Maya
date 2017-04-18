//
//  MayaCalendarDataSource.swift
//  Pods
//
//  Created by Ivan Bruel on 01/03/16.
//
//

import UIKit

@objc public protocol MayaCalendarDataSource {

  optional func calenderDateString(_ date: MayaDate) -> String?
  optional func calendarMonthName(_ month: MayaMonth) -> String?
  optional func calendarTextColorForDate(_ date: MayaDate) -> UIColor?
  optional func calendarBackgroundColorForDate(_ date: MayaDate) -> UIColor?
  optional func calendarFontForDate(_ date: MayaDate) -> UIFont?
  
}
