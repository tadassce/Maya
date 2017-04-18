//
//  MayaMonthViewModel.swift
//  Pods
//
//  Created by Ivan Bruel on 01/03/16.
//
//

import Foundation

class MayaMonthViewModel {

  fileprivate let dates: [MayaDate]

  let weekdays: [String]
  let weekdayFont: UIFont
  let weekdayTextColor: UIColor
  let viewModels: [MayaDayViewModel]
  let dayClicked: ((MayaDate) -> Void)

  init(month: MayaMonth, weekdays: [String], weekdayTextColor: UIColor, weekdayFont: UIFont,
       dayFont: UIFont, dataSource: MayaCalendarDataSource?, dayClicked: (MayaDate) -> Void) {
    self.dayClicked = dayClicked
    dates = MayaMonthViewModel.datesForMonth(month)
    self.weekdayFont = weekdayFont
    self.weekdays = weekdays
    self.weekdayTextColor = weekdayTextColor
    viewModels = dates.map { date in
      let dayTextColor = dataSource?.calendarTextColorForDate?(date) ?? UIColor.black
      let dayBackgroundColor = dataSource?.calendarBackgroundColorForDate?(date)
        ?? UIColor.clear
      let dayFont = dataSource?.calendarFontForDate?(date) ?? dayFont
      let otherMonth = date.month != month.month
      let textColor = otherMonth ? dayTextColor.withAlphaComponent(0.5) : dayTextColor
      let backgroundColor = otherMonth && UIColor.clear != dayBackgroundColor ?
        dayBackgroundColor.withAlphaComponent(0.5) : dayBackgroundColor
      return MayaDayViewModel(date: date, dateText: dataSource?.calenderDateString?(date),
        font: dayFont, textColor: textColor, backgroundColor: backgroundColor)
    }
  }

  func viewModelClicked(_ index: Int) {
    dayClicked(dates[index])
  }
}

extension MayaMonthViewModel {

  fileprivate static func datesForMonth(_ month: MayaMonth) -> [MayaDate] {
    let previousMonth = month.previousMonth
    let nextMonth = month.nextMonth

    var dates = [MayaDate]()

    if previousMonth.lastDate.weekOfYear == month.firstDate.weekOfYear {
      dates += previousMonth.lastWeek
    }
    dates += month.dates
    for nextWeek in 0...6-month.numberOfWeeks {
      dates += nextMonth.weeks[nextWeek]
      if dates.count == 6*7 {
        break
      }
    }
    return dates
  }

}
