//
//  StudentCourseModel.swift
//  Estaed
//
//  Created by arwa balawi on 29/05/1443 AH.
//

import Foundation

struct StudentCourse {
  var courseId : String
  var studentId : String
  var isPaid : Bool
  
  init(courseId :String ,
       stuId:String ,
       isPaid : Bool) {
    self.studentId = stuId
    self.courseId = courseId
    self.isPaid = isPaid
  }
  
  init() {
    self.studentId = ""
    self.courseId = ""
    self.isPaid = false
  }
  
  
  init(value : NSDictionary) {
    self.studentId = value["StudentId"] as! String
    self.courseId = value["courseId"] as! String
    self.isPaid = value["isPaid"] as! Bool
    
  }
  
  
  func toDictionary() -> Any {
    return [
      "courseId" : self.courseId,
      "StudentId":self.studentId,
      "isPaid": self.isPaid
    ] as Any
  }
}

