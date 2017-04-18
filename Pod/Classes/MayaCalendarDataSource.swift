//
//  MayaCalendarDataSource.swift
//  Pods
//
//  Created by Ivan Bruel on 01/03/16.
//
//

import UIKit

@objc public protocol MayaCalendarDataSource {

  @objc optional func calenderDateString(_ date: MayaDate) -> String?
  @objc optional func calendarMonthName(_ month: MayaMonth) -> String?
  @objc optional func calendarTextColorForDate(_ date: MayaDate) -> UIColor?
  @objc optional func calendarBackgroundColorForDate(_ date: MayaDate) -> UIColor?
  @objc optional func calendarFontForDate(_ date: MayaDate) -> UIFont?
  
}
