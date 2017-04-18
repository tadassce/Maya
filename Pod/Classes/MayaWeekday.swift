//
//  MayaWeekday.swift
//  Pods
//
//  Created by Ivan Bruel on 01/03/16.
//
//

import Foundation

@objc public enum MayaWeekday: Int {
  case sunday = 1
  case monday = 2
  case tuesday = 3
  case wednesday = 4
  case thursday = 5
  case friday = 6
  case saturday = 7

  var isWeekend: Bool {
    switch self {
    case .sunday, .saturday:
      return true
    default:
      return false
    }
  }
}
