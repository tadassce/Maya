//
//  MayaMonth.swift
//  Pods
//
//  Created by Ivan Bruel on 01/03/16.
//
//

import Foundation

open class MayaMonth: NSObject {

  fileprivate static let calendar = Calendar.current

  open let month: Int
  open let year: Int

  public init(month: Int, year: Int) {
    self.month = month
    self.year = year
  }

  convenience public init(mayaDate: MayaDate) {
    self.init(date: mayaDate.date)
  }

  convenience public init(date: Date) {
    let components = (MayaMonth.calendar as NSCalendar).components([.month , .year], from: date)

    self.init(month: components.month!, year: components.year!)
  }

  open var date: Date {
    var components = DateComponents()
    components.month = month
    components.year = year
    return MayaMonth.calendar.date(from: components) ?? Date()
  }

  open var name: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM"
    return dateFormatter.string(from: date)
  }

  open var numberOfDays: Int {
    return (MayaMonth.calendar as NSCalendar).range(of: .day, in: .month, for: date).length
  }

  open var numberOfWeeks: Int {
    return (MayaMonth.calendar as NSCalendar).components(.weekOfMonth, from: lastDate.date).weekOfMonth!
  }

  open var firstDate: MayaDate {
    return MayaDate(day: 1, month: month, year: year)
  }

  open var lastDate: MayaDate {
    return MayaDate(day: 0, month: month+1, year: year)
  }

  open var weeks: [[MayaDate]] {
    var weeks = [[MayaDate]]()
    for index in 0...numberOfWeeks {
      let days = dates.filter { $0.weekOfMonth == index &&
        MayaMonth(mayaDate: $0).compare(self) == .orderedSame }
      if days.count > 0 {
        weeks.append(days)
      }
    }
    return weeks
  }

  open var firstWeek: [MayaDate] {
    return weeks[0]
  }

  open var lastWeek: [MayaDate] {
    return weeks[weeks.count-1]
  }

  open var dates: [MayaDate] {
    var dates = [MayaDate]()
    for index in 1...numberOfDays {
      dates.append(MayaDate(day: index, month: month, year: year))
    }
    return dates
  }

  open var previousMonth: MayaMonth {
    return monthWithOffset(-1)
  }

  open var nextMonth: MayaMonth {
    return monthWithOffset(1)
  }

  open func monthWithOffset(_ offset: Int) -> MayaMonth {
    return MayaMonth(month: month+offset, year: year)
  }

  open func numberOfMonthsUntil(_ month: MayaMonth) -> Int {
    let components = (MayaMonth.calendar as NSCalendar).components(.month, from: date, to: month.date,
      options: [])

    return components.month!
  }

  override open func isEqual(_ object: Any?) -> Bool {
    guard let rhs = object as? MayaMonth else {
      return false
    }

    return date.compare(rhs.date) == .orderedSame
  }

  open func compare(_ otherMonth: MayaMonth) -> ComparisonResult {
    return date.compare(otherMonth.date)
  }
  
}
