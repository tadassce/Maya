//
//  MayaWeekday.swift
//  Pods
//
//  Created by Ivan Bruel on 01/03/16.
//
//

import Foundation

@objc public enum MayaWeekday: Int {
  case Sunday = 1
  case Monday = 2
  case Tuesday = 3
  case Wednesday = 4
  case Thursday = 5
  case Friday = 6
  case Saturday = 7

  var isWeekend: Bool {
    switch self {
    case .Sunday, .Saturday:
      return true
    default:
      return false
    }
  }
}