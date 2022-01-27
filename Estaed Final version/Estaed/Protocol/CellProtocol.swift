//
//  CellProtocol.swift
//  Estaed
//
//  Created by arwa balawi on 17/05/1443 AH.
//

import Foundation
import UIKit

protocol MyCellDelegate: AnyObject {
  
    func didPressButton(_ tag: Int)
}

protocol newCellDelegate: AnyObject {
  
  func didPressButton(_ tag: Int, _ Sender : UIButton)
}
