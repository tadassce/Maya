//
//  MayaMonth.swift
//  Pods
//
//  Created by Ivan Bruel on 01/03/16.
//
//

import Foundation

public class MayaMonth: NSObject {

  private static let calendar = NSCalendar.currentCalendar()

  public let month: Int
  public let year: Int

  public init(month: Int, year: Int) {
    self.month = month
    self.year = year
  }

  convenience public init(mayaDate: MayaDate) {
    self.init(date: mayaDate.date)
  }

  convenience public init(date: NSDate) {
    let components = MayaMonth.calendar.components([.Month , .Year], fromDate: date)

    self.init(month: components.month, year: components.year)
  }

  public var date: NSDate {
    let components = NSDateComponents()
    components.month = month
    components.year = year
    return MayaMonth.calendar.dateFromComponents(components) ?? NSDate()
  }

  public var name: String {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "MMMM"
    return dateFormatter.stringFromDate(date)
  }

  public var numberOfDays: Int {
    return MayaMonth.calendar.rangeOfUnit(.Day, inUnit: .Month, forDate: date).length
  }

  public var numberOfWeeks: Int {
    return MayaMonth.calendar.components(.WeekOfMonth, fromDate: lastDate.date).weekOfMonth
  }

  public var firstDate: MayaDate {
    return MayaDate(day: 1, month: month, year: year)
  }

  public var lastDate: MayaDate {
    return MayaDate(day: 0, month: month+1, year: year)
  }

  public var weeks: [[MayaDate]] {
    var weeks = [[MayaDate]]()
    for index in 1...numberOfWeeks {
      weeks.append(dates.filter { $0.weekOfMonth == index })
    }
    return weeks
  }

  public var firstWeek: [MayaDate] {
    return weeks[0]
  }

  public var lastWeek: [MayaDate] {
    return weeks[numberOfWeeks-1]
  }

  public var dates: [MayaDate] {
    var dates = [MayaDate]()
    for var index = 1; index <= numberOfDays; index++ {
      dates.append(MayaDate(day: index, month: month, year: year))
    }
    return dates
  }

  public var previousMonth: MayaMonth {
    return monthWithOffset(-1)
  }

  public var nextMonth: MayaMonth {
    return monthWithOffset(1)
  }

  public func monthWithOffset(offset: Int) -> MayaMonth {
    return MayaMonth(month: month+offset, year: year)
  }

  public func numberOfMonthsUntil(month: MayaMonth) -> Int {
    let components = MayaMonth.calendar.components(.Month, fromDate: date, toDate: month.date,
      options: [])

    return components.month
  }

  override public func isEqual(object: AnyObject?) -> Bool {
    guard let rhs = object as? MayaMonth else {
      return false
    }

    return date.compare(rhs.date) == .OrderedSame
  }

  public func compare(otherMonth: MayaMonth) -> NSComparisonResult {
    return date.compare(otherMonth.date)
  }

}
