//
//  MayaCalendarCollectionViewCell.swift
//  Pods
//
//  Created by Ivan Bruel on 01/03/16.
//
//

import UIKit

class MayaCalendarMonthCollectionViewCell: UICollectionViewCell {

  @IBOutlet var dayButtons: [UIButton]!
  @IBOutlet var weekdayLabels: [UILabel]!

  var clickBlock: ((MayaDate) -> Void)?

  @IBAction func dayClicked(button: UIButton) {
    guard let index = dayButtons.indexOf(button) else {
      return
    }
    viewModel.viewModelClicked(index)
  }
  

  var viewModel: MayaMonthViewModel! {
    didSet {
      for index in 0..<viewModel.weekdays.count {
        weekdayLabels[index].text = viewModel.weekdays[index]
      }

      for index in 0..<viewModel.viewModels.count {
        let dayViewModel = viewModel.viewModels[index]
        let dayButton = dayButtons[index]
        
        dayButton.setTitle(dayViewModel.day, forState: .Normal)
        dayButton.setTitleColor(dayViewModel.textColor, forState: .Normal)
        dayButton.titleLabel?.font = dayViewModel.font
        dayButton.backgroundColor = dayViewModel.backgroundColor
      }
    }
  }

}