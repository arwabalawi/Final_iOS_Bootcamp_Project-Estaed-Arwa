//
//  Challenges.swift
//  Estaed
//
//  Created by arwa balawi on 22/05/1443 AH.
//

import Foundation
import UIKit

struct ChallengAttachment {
  
  var challengId : String
  var numberOfCH : String
  var titleOfCH : String
  var numberOfweek : String
  var difficultylevel : String
  var subjectOfCH : String
  var courseId : String
  var isCompLeted : Bool
  
  func toDictionary() -> Any {
    return [
      "ChallengId" : self.challengId,
      "numberOfCH":self.numberOfCH,
      "titleOfCH": self.titleOfCH,
      "numberOfweek" : self.numberOfweek,
      "difficultylevel" : self.difficultylevel,
      "subjectOfCH" : self.subjectOfCH,
      "courseId" : self.courseId,
      "isCompLeted" : self.isCompLeted
    ]  as Any
  }
  
  
  init(value : NSDictionary) {
    self.challengId = value["ChallengId"] as! String
    self.numberOfCH = value["numberOfCH"] as! String
    self.titleOfCH = value["titleOfCH"] as! String
    self.numberOfweek = value["numberOfweek"] as! String
    self.difficultylevel = value["difficultylevel"] as! String
    self.subjectOfCH = value["subjectOfCH"] as! String
    self.courseId = value["courseId"] as! String
    self.isCompLeted = value["isCompLeted"] as! Bool
  }
  
  
  init(challengId : String,
       numberOfCH : String ,
       titleOfCH : String,
       numberOfweek : String,
       difficultylevel : String,
       subjectOfCH : String,
       cId :String,
       isCompLeted:Bool) {
    self.challengId = challengId
    self.numberOfCH = numberOfCH
    self.titleOfCH = titleOfCH
    self.numberOfweek = numberOfweek
    self.difficultylevel = difficultylevel
    self.subjectOfCH = subjectOfCH
    self.courseId = cId
    self.isCompLeted = isCompLeted
  }
  
  
  init() {
    self.challengId = ""
    self.numberOfCH = ""
    self.titleOfCH = ""
    self.numberOfweek = ""
    self.difficultylevel = ""
    self.subjectOfCH = ""
    self.courseId = ""
    self.isCompLeted = false
  }
  
}
