//
//  MayaDate.swift
//  Pods
//
//  Created by Ivan Bruel on 01/03/16.
//
//

import Foundation

public class MayaDate: NSObject {

  private static let calendar = NSCalendar.currentCalendar()

  public let day: Int
  public let month: Int
  public let year: Int

  public init(day: Int, month: Int, year: Int) {
    self.day = day
    self.month = month
    self.year = year
  }

  convenience public init(date: NSDate) {
    let components = MayaDate.calendar.components([.Day , .Month , .Year], fromDate: date)

    self.init(day: components.day, month: components.month, year: components.year)
  }

  public var weekday: MayaWeekday {
    return MayaWeekday(rawValue: MayaDate.calendar.components([.Weekday], fromDate: date).weekday)
      ?? .Sunday
  }

  public var weekOfMonth: Int {
    return MayaDate.calendar.components([.WeekOfMonth], fromDate: date).weekOfMonth
  }

  public var weekOfYear: Int {
    return MayaDate.calendar.components([.WeekOfYear], fromDate: date).weekOfYear
  }

  public var date: NSDate {
    let components = NSDateComponents()
    components.day = day
    components.month = month
    components.year = year
    return MayaDate.calendar.dateFromComponents(components) ?? NSDate()
  }

  public var isWeekend: Bool {
    return weekday.isWeekend
  }

  public var previousDate: MayaDate {
    return dateWithOffset(-1)
  }

  public var nextDate: MayaDate {
    return dateWithOffset(1)
  }

  public func dateWithOffset(offset: Int) -> MayaDate {
    return MayaDate(day: day+offset, month: month, year: year)
  }

  override public func isEqual(object: AnyObject?) -> Bool {
    guard let rhs = object as? MayaDate else {
      return false
    }

    return date.compare(rhs.date) == .OrderedSame
  }

  public func compare(otherDate: MayaDate) -> NSComparisonResult {
    return date.compare(otherDate.date)
  }

  public func between(firstDate: MayaDate, lastDate: MayaDate) -> Bool {
    return compare(firstDate) == .OrderedDescending
      && compare(lastDate) == .OrderedAscending
  }

  public static var today: MayaDate {
    return MayaDate(date: NSDate())
  }

}
