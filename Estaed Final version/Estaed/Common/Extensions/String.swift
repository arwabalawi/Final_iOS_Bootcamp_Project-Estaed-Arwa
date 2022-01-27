//
//  K.swift
//  Estaed
//
//  Created by arwa balawi on 22/06/1443 AH.
//

import Foundation

extension String {
  
  var localized : String {
  return NSLocalizedString(self,
                           tableName: "Localizable",
                           comment: self)
}
}
