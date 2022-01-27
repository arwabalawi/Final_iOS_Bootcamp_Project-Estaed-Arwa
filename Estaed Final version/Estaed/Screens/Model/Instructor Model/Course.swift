//
//  Course details.swift
//  Estaed
//
//  Created by arwa balawi on 11/05/1443 AH.
//

import Foundation

struct Course {
  var courseId : String
  var courseName : String
  var courseContents : String
  var courseDate : String
  var coursePrice : String
  var courseTimeKind : String   
  var instructorsId : String
  
  
  init(){
    self.courseId = ""
    self.courseName = ""
    self.courseContents = ""
    self.courseDate = ""
    self.coursePrice = ""
    self.courseTimeKind = ""
    self.instructorsId = ""
  }
  
  
  init(cId : String,
       cName : String ,
       cContent : String ,
       cDate : String ,
       cPrice : String ,
       cTimeKind : String ,
       insId : String) {
    self.courseId = cId
    self.courseName = cName
    self.courseContents = cContent
    self.courseDate = cDate
    self.coursePrice = cPrice
    self.courseTimeKind = cTimeKind
    self.instructorsId = insId
  }
  
  
  init(value : NSDictionary) {
    self.courseId = value["courseId"] as! String
    self.courseName = value["courseName"] as! String
    self.courseContents = value["courseContents"] as! String
    self.courseDate = value["courseDate"] as! String
    self.coursePrice = value["coursePrice"] as! String
    self.courseTimeKind = value["courseTimeKind"] as! String
    self.instructorsId = value["instructorsId"] as! String
  }
  
  
  func toDictionary() -> Any {
    return [
      "courseId" : self.courseId,
      "courseName":self.courseName,
      "courseContents": self.courseContents,
      "courseDate" : self.courseDate,
      "coursePrice" : self.coursePrice,
      "courseTimeKind" : self.courseTimeKind,
      "instructorsId" : self.instructorsId
    ]  as Any
  }
  
}
