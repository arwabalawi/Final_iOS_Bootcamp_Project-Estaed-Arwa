//
//  TeacherAddCourse.swift
//  Estaed
//
//  Created by arwa balawi on 10/05/1443 AH.
//
import Foundation
import UIKit
import FirebaseDatabase
import Firebase
import FirebaseCore
class InstructorsAddCourse : UIViewController {
  
  // MARK: - Properties
  
  var ref : DatabaseReference!
  let datePicker = UIDatePicker()

  // MARK: - IBOtlets
  
    @IBOutlet weak var coursePrice: UITextField!
    @IBOutlet weak var courseName: UISwitch!
    @IBOutlet weak var courseDate: UITextField!
    @IBOutlet weak var courseContents: UITextField!
    @IBOutlet weak var courseTimeKind: UISwitch!
    @IBOutlet weak var add: UIButton!
  
  
  // MARK: - View controller lifecycle
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
   
    ref = Database.database().reference()
    createDatePicker()
  }
  
  
  
  
  //MARK: - Methoda
  
  
  //To: -create Date Picker programmatically
  func createDatePicker() {
    
    courseDate.textAlignment = .left
    //Too: toolbar
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    
    //bar button
    let doneBtn = UIBarButtonItem(barButtonSystemItem: .done,
                                  target: nil,
                                  action: #selector(donePressed))
    toolbar.setItems([doneBtn],
                     animated: true)
    
    //assign toolbar
    courseDate.inputAccessoryView = toolbar
    
    //assign date picker to text field
    courseDate.inputView = datePicker
    
    //date picker mode
    datePicker.datePickerMode = .date
    datePicker.frame = .init(x: 10, y: 100,
                             width:view.frame.width,
                             height: 200)
  }
  
  
  //To: Check that all fields are filled in
  func validateFields() -> String? {
    
    if coursePrice.text! == "" ||
        courseDate.text! == ""  ||
        courseContents.text == ""
    {
      return "please fill in all fields.".localized
    }
    return nil
  }
  
  
  //To: formatter Date Picker
  @objc func donePressed(){
    
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
  
    courseDate.text = formatter.string(from: datePicker.date)
    self.view.endEditing(true)
  }
  
  
  //To: Transfer to next textfield directly
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    if textField == courseContents {
      courseDate.becomeFirstResponder()
      
    } else if  textField == courseDate {
      coursePrice.becomeFirstResponder()
    }
    else
    {
      //hide the keyboard
      view.endEditing(true)
    }
    return true
  }
  
  
  
  //MARK: - IBAction
  
  
  //To: -Register in the database
    @IBAction func AddButoon(_ sender: Any) {
      
      let instructorsId = K.RealtimeDatabase.userId
      let pcourseName : String = courseName.isOn ?  K.RealtimeDatabase.qudrat : K.RealtimeDatabase.tahsely
      
      let pcourseTimeKind = courseTimeKind.isOn ? K.RealtimeDatabase.normal : K.RealtimeDatabase.crash
      
      let course = Course(cId: UUID.init().uuidString,
                               cName: pcourseName,
                               cContent: courseContents.text!,
                               cDate: courseDate.text!,
                               cPrice: coursePrice.text!,
                               cTimeKind: pcourseTimeKind,
                               insId: instructorsId)
    let error = validateFields()
    if error != nil {
      
      //If it is empty
      K.getMsg(title:"Error!".localized,
                      Msg: "Error In Validating Data".localized,
                      context: self)
    }
    else
    {
      
    //Register in the database
      self.ref.child("courses").child(instructorsId).child(course.courseId).setValue(course.toDictionary()) { Error, DataRef in
        
        if Error == nil
        {
          //If it is not empty
          K.getMsg(title:"Nice Work".localized,
                          Msg:"Course Added Successfully".localized,
                             context: self)
          {  result, error in
                if !error
                {
                    self.dismiss(animated: true,
                                 completion: nil)
                }
            }
        }
        else
        {
          print(Error.debugDescription)
        }
      }
    }
  }
  
}
