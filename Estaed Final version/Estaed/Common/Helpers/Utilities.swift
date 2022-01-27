
//
//  Utilities.swift
//  Estaed
//
//  Created by arwa balawi on 10/05/1443 AH.
//

import UIKit

class Utilities {
  
  static func styleTextField( textfield:UITextField) {
    
 //Create the bottom line
  let bottomLine = CALayer()
  bottomLine.frame = CGRect(x: 0,
                            y: textfield.frame.height - 2,
                            width: textfield.frame.width,
                            height: 2)

  bottomLine.backgroundColor = UIColor.init(red: 146/255,
                                              green: 129/255,
                                              blue: 122/255,
                                              alpha: 1).cgColor

  }

  static func styleFilledButton(_ button:UIButton) {

  // Filled rounded corner style
    button.backgroundColor = UIColor.init(red: 0/255,
                                          green: 0/255,
                                          blue: 0/255,
                                          alpha: 1)
    button.layer.cornerRadius = 20.0
    button.tintColor = UIColor.black
  }

  
  static func styleHollowButton(_ button:UIButton) {
    
  // Hollow rounded corner style
    button.layer.borderWidth = 2
    button.layer.borderColor = UIColor.black.cgColor
    button.layer.cornerRadius = 25.0
    button.tintColor = UIColor.black

  }

  
  static func isPasswordValid (_ password : String) -> Bool{
    
  let passwordTest = NSPredicate(format: "SELF MATCHES %@",  "^(?=.*[a-z])(?=.*[$@$#!%*?&_])[A-Za-z\\d$@$#!%*?&_]{8,}")

  return passwordTest.evaluate(with: password)

  }
  
  }
  

  
