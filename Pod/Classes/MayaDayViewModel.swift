//
//  MayaDayViewModel.swift
//  Pods
//
//  Created by Ivan Bruel on 01/03/16.
//
//

import UIKit

class MayaDayViewModel {

  fileprivate let date: MayaDate
  
  let day: String
  let font: UIFont
  let textColor: UIColor
  let backgroundColor: UIColor

  init(date: MayaDate, dateText: String? = nil, font: UIFont, textColor: UIColor, backgroundColor: UIColor) {
    self.date = date
    self.font = font
    day = dateText ?? "\(date.day)"
    self.textColor = textColor
    self.backgroundColor = backgroundColor
  }

}
