//
//  LectureViewController.swift
//  Estaed
//
//  Created by arwa balawi on 29/05/1443 AH.
//

import Foundation
import UIKit
import FirebaseDatabase
import Firebase
import FirebaseCore


class LectureViewController: UIViewController {
  
  // MARK: - Properties
  
  let PickerDate = UIDatePicker()
  let pickerSection = UIPickerView()
  var date = ""
  var time = ""
  var ref : DatabaseReference!
  var LectureModelList = [Lecture]()
  var courseId = ""
  
  
  // MARK: - IBOtlets
  
  
  @IBOutlet weak var LectureName: UITextField!
  @IBOutlet weak var lectureLink: UITextField!
  @IBOutlet weak var ErrorLabel: UILabel!
  @IBOutlet weak var addbtn: UIButton!
  @IBOutlet weak var pickerDate: UIDatePicker!
  
  
  //MARK: - View controller lifecycle
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  
  //MARK: -Methods
  
  
  
  //Check that all fields are filled in
  func validateFields() -> String? {
    if    LectureName.text!.isEmpty  ||
            lectureLink.text!.isEmpty  ||
            date.isEmpty ||
            time.isEmpty
    
    {
      return "please fill in all fields.".localized
    }
    return nil
  }
  
  
  
  // MARK: - IBAction
  
  
  @IBAction func DateChanged(_ sender: UIDatePicker) {

    let getdate = sender.date
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "dd-MM-yyyy"
    self.date = dateFormatter.string(from: getdate)
    print(self.date)
    
    let components = Calendar.current.dateComponents([.hour,.minute],
                                                     from: getdate)
    var hour = components.hour!
    var kind = " A.M"
    let minute = components.minute!
    if hour > 12
    {
      hour = hour - 12
      kind = " P.M"
    }
    self.time = String (hour) + " : " + String(minute) + kind
    
    print(self.time)
  }
  
  
  //To: Set data in Firebace
  @IBAction func addBtn(_ sender: Any) {
    
    //Too: -validate
    let error = validateFields()
    if error != nil {
      
      K.getMsg(title:"Error!".localized,
               Msg: "Error In Validating Data".localized,
               context: self)
      
    } else {
      
      let LectId = UUID.init().uuidString
      
      let LectureModelList = Lecture(lectureName: self.LectureName.text!,
                                     lectureURL: self.lectureLink.text!,
                                     lectureTime: self.time,
                                     lectureDate: self.date,
                                     courseId: self.courseId )
      
      ref = Database.database().reference()
      self.ref.child(K.RealtimeDatabase.lectures).child(LectureModelList.courseId).child(LectId).setValue(LectureModelList.toDictionary()) {Error, DataRef in
        
        if Error == nil
        {
          K.getMsg(title:"Nice Work".localized,
                   Msg: "lecture Added Successfully".localized,
                   context: self){  result,
                                    error in
            if !error
            {
              self.dismiss(animated: true, completion: nil)
              
            }
          }
        }else{
          print(Error.debugDescription)
        }
      }
    }
  }
  
}
