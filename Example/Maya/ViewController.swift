//
//  ViewController.swift
//  Maya
//
//  Created by Ivan Bruel on 03/01/2016.
//  Copyright (c) 2016 Ivan Bruel. All rights reserved.
//

import UIKit
import Maya

class ViewController: UIViewController {

  @IBOutlet weak var calendarView: MayaCalendarView!

  var selectedDate: MayaDate?

  override func viewDidLoad() {
    super.viewDidLoad()
    calendarView.weekdays = ["su", "mo", "tu", "we", "th", "fr", "sa"]
    calendarView.monthFont = .boldSystemFontOfSize(18)
    calendarView.weekdayFont = .systemFontOfSize(15)
    calendarView.dayFont = .systemFontOfSize(16)
    calendarView.weekdayTextColor = .blackColor()
    calendarView.firstMonth = MayaMonth(month: 1, year: 2016)
    calendarView.lastMonth = MayaMonth(month: 8, year: 2016)
    calendarView.currentMonth = MayaMonth(month: 3, year: 2016)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

extension ViewController: MayaCalendarDataSource {

  func calendarMonthName(month: MayaMonth) -> String? {
    return "\(month.name.uppercaseString)"
  }

  func calendarWeekdayName(weekday: MayaWeekday) -> String? {
    switch weekday {
    case .Sunday:
      return "su"
    case .Monday:
      return "mo"
    case .Tuesday:
      return "tu"
    case .Wednesday:
      return "we"
    case .Thursday:
      return "th"
    case .Friday:
      return "fr"
    case .Saturday:
      return "sa"
    }
  }

  func calendarTextColorForDate(date: MayaDate) -> UIColor? {
    if date == selectedDate || date == MayaDate.today {
      return UIColor.whiteColor()
    }
    return nil
  }

  func calendarBackgroundColorForDate(date: MayaDate) -> UIColor? {
    if date == selectedDate {
      return UIColor.redColor()
    } else if date == MayaDate.today {
      return UIColor.blueColor()
    }
    return nil
  }

}

extension ViewController: MayaCalendarDelegate {

  func calendarDidSelectDate(date: MayaDate) {
    guard date.compare(MayaDate.today) != .OrderedAscending else {
      print("not selecting date before today")
      return
    }
    selectedDate = date
    calendarView.reloadData()
    print("selected date \(date.day)")
  }

  func calendarDidChangeMonth(month: MayaMonth) {
    print("Changed month to \(month.name)")
  }
  
}