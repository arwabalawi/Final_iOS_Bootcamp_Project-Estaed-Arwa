//
//  StudentCourseDetailsModel.swift
//  Estaed
//
//  Created by arwa balawi on 19/05/1443 AH.
//

import Foundation
import UIKit


struct  StudentCourseDetail {
  
  var sCourseContents : String
  var sCourseDate : String
  var sCoursePrice : String
  
  
  func toDictionary() -> Any {
    return [
      "sCourseContents" : self.sCourseContents,
      "sCourseDate": self.sCourseDate,
      "sCoursePrice": self.sCoursePrice,
    ] as Any
  }
  
  
  init(value : NSDictionary) {
    self.sCourseContents = value["sCourseContents"] as! String
    self.sCourseDate = value["sCourseDate"] as! String
    self.sCoursePrice = value["sCoursePrice"] as! String
    
  }
  
  
  init(sCourseContents : String,
       sCourseDate : String,
       sCoursePrice : String ) {
    self.sCourseContents = sCourseContents
    self.sCourseDate = sCourseDate
    self.sCoursePrice = sCoursePrice
  }
  
}








