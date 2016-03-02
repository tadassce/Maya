//
//  MayaCollectionViewFlowLayout.swift
//  Pods
//
//  Created by Ivan Bruel on 02/03/16.
//
//

import UIKit

class MayaCollectionViewFlowLayout: UICollectionViewFlowLayout {

  override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
    return true
  }

}
