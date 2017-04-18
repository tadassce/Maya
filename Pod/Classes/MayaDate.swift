//
//  MayaDate.swift
//  Pods
//
//  Created by Ivan Bruel on 01/03/16.
//
//

import Foundation

open class MayaDate: NSObject {

  fileprivate static let calendar = Calendar.current

  open let day: Int
  open let month: Int
  open let year: Int

  public init(day: Int, month: Int, year: Int) {
    self.day = day
    self.month = month
    self.year = year
  }

  convenience public init(date: Date) {
    let components = (MayaDate.calendar as NSCalendar).components([.day , .month , .year], from: date)

    self.init(day: components.day!, month: components.month!, year: components.year!)
  }

  open var weekday: MayaWeekday {
    return MayaWeekday(rawValue: (MayaDate.calendar as NSCalendar).components([.weekday], from: date).weekday!)
      ?? .sunday
  }

  open var weekOfMonth: Int {
    return (MayaDate.calendar as NSCalendar).components([.weekOfMonth], from: date).weekOfMonth!
  }

  open var weekOfYear: Int {
    return (MayaDate.calendar as NSCalendar).components([.weekOfYear], from: date).weekOfYear!
  }

  open lazy var date: Date = {
    var components = DateComponents()
    components.day = self.day
    components.month = self.month
    components.year = self.year
    return MayaDate.calendar.date(from: components) ?? Date()
  }()

  open var isWeekend: Bool {
    return weekday.isWeekend
  }

  open var previousDate: MayaDate {
    return dateWithOffset(-1)
  }

  open var nextDate: MayaDate {
    return dateWithOffset(1)
  }

  open func dateWithOffset(_ offset: Int) -> MayaDate {
    return MayaDate(day: day+offset, month: month, year: year)
  }

  override open func isEqual(_ object: Any?) -> Bool {
    guard let rhs = object as? MayaDate else {
      return false
    }

    return date.compare(rhs.date) == .orderedSame
  }

  open func compare(_ otherDate: MayaDate) -> ComparisonResult {
    return date.compare(otherDate.date)
  }

  open func between(_ firstDate: MayaDate, lastDate: MayaDate) -> Bool {
    return compare(firstDate) == .orderedDescending
      && compare(lastDate) == .orderedAscending
  }

  open static var today: MayaDate {
    return MayaDate(date: Date())
  }

  open override var hash: Int {
    return Int(round(date.timeIntervalSince1970))
  }

}
