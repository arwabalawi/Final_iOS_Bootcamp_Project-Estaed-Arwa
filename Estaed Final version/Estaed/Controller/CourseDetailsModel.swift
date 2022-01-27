//
//  Course details.swift
//  Estaed
//
//  Created by arwa balawi on 11/05/1443 AH.
//

import Foundation

struct CourseDetailsModel {
  
  var CourseName : String
  var addteachername : String
  var addcoursecontents : String
  var addcoursetime : String
  var addcourseprice : String
  var CourseKind : String
    
    func toDic() -> Any
    {
        return [
            "CourseName":self.CourseName,
            "addteachername" : self.addteachername,
            "addcoursecontents": self.addcoursecontents,
            "addcoursetime" : self.addcoursetime,
            "addcourseprice" : self.addcourseprice,
            "CourseKind" : self.CourseKind
        ]  as Any
    }
  
}
