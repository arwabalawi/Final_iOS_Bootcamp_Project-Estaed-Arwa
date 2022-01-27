//
//  User.swift
//  Estaed
//
//  Created by arwa balawi on 29/05/1443 AH.
//

import Foundation

struct User {
  var firstName : String
  var lasteName : String
  var password : String = ""
  var email : String
  var userType  : Int     //  0 admin   1 instractor   2 student
  var imageUrl : String
  
  
  init() {
    self.firstName = ""
    self.lasteName = ""
    self.email = ""
    self.userType = 2
    self.imageUrl = ""
  }
  
  
  init(firstName : String ,
       lastName : String ,
       email : String ,
       imageUrl : String ,
       userType : Int) {
    self.firstName = firstName
    self.lasteName = lastName
    self.email = email
    self.userType = userType
    self.imageUrl = imageUrl
  }
  
  
  init(value : NSDictionary) {
    self.firstName = value["firstName"] as! String
    self.lasteName = value["lastName"] as! String
    self.email = value["email"] as! String
    self.userType = value["userType"] as! Int
    self.imageUrl = value["imageUrl"] as! String
  }
  
  
  func toDictionary() -> Any {
    return [
      "firstName" : self.firstName,
      "lastName" : self.lasteName,
      "email" : self.email,
      "userType" : self.userType,
      "imageUrl" : self.imageUrl
    ] as Any
  }
}

