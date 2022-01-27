//
//  ChallengAttachmentViewController.swift
//  Estaed
//
//  Created by arwa balawi on 24/05/1443 AH.
//

import Foundation
import UIKit
import FirebaseDatabase
import Firebase
import FirebaseCore

class ChallengAttachmentViewController: UIViewController,
                                        UIPickerViewDelegate,
                                        UIPickerViewDataSource,
                                        UITextFieldDelegate {
  
  // MARK: - Properties
  
  var ref : DatabaseReference!
  let piker = UIPickerView()
  let toolBar = UIToolbar()
  var transferedCId : String = ""
  
  var numOfWeekcurrentIndex = 0 ,
      numOfChcurrentIndex = 0 ,
      subjectcurrentIndex = 0 ,
      diffcurrentIndex = 0
  
  
  var numofWeek = false ,
      numOfch = false ,
      subjectch = false ,
      diff = false
  
  var arrNumberOfCh = [String]()
  var arrNumberOfWeek = [String]()
  var arrsubjectOfCh = [String]()
  var arrdifficultyLevel = ["Easy","Medium","Hard"]
  
  
  // MARK: - IBOtlets
  
  @IBOutlet weak var selectNumberOfWeek: UITextField!
  @IBOutlet weak var selectNumberOfCh: UITextField!
  @IBOutlet weak var subjectOfCh: UITextField!
  @IBOutlet weak var difficultyLevel: UITextField!
  @IBOutlet weak var titleOfCh: UITextField!
  @IBOutlet weak var addBtn: UIButton!
  @IBOutlet weak var disMissButton: UIButton!
  
 
  // MARK: - View controller lifecycle
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupArrays()
    piker.delegate = self
    piker.dataSource = self
    difficultyLevel.delegate = self
    
    
    toolBar.sizeToFit()
    let btnDone = UIBarButtonItem(title:"Done".localized,
                                  style: .plain ,
                                  target: self , action: #selector(closePicker))
    toolBar.setItems([btnDone],
                     animated: true)
    
    getTextFieldEvent()
    setUpElements()
    ref = Database.database().reference().child(K.RealtimeDatabase.challenge).child(transferedCId)
    
  }
  
  
  override func touchesBegan(_ touches: Set<UITouch>,
                             with event: UIEvent?) {
    view.endEditing(true)
  }
  
  
  
  
  //MARK: - Methods
  
  func setupArrays()
  {
    let courseName = K.RealtimeDatabase.courseName
    let courseTimeKind = K.RealtimeDatabase.courseTimeKind
    
    if courseName == K.RealtimeDatabase.tahsely
    {
      arrsubjectOfCh = ["Mathematics","Chemistry","Biology","Physics"]
      
      if courseTimeKind == K.RealtimeDatabase.normal
      {
        arrNumberOfCh = ["1) ","2)","3)","4)","5)","6)","7)","8)","9)","10)","11)","12)","13)","14)","15)","16)","17)","18)","19)","20)"]
        arrNumberOfWeek = ["first week","second week","third week","fourth week","fifth week","sixth week","Seventh week", "eighth week","ninth week","tenth week","eleventh week","Twelfth week"]
  
      }
      else
      {
        arrNumberOfCh = ["1) ","2)","3)","4)","5)","6)","7)","8)","9)","10)","11)","12)","13)","14)","15)","16)","17)","18)","19)","20)","21)","22)","23)","24)","25)","26)","27)","28)","29)","30)","31)","32)","33)","34)","35)","36)","37)","38)","39)","40)"]
        arrNumberOfWeek = ["first week","second week","third week","fourth week","fifth week","sixth week"]
      }
      
    }
    else
    {
      arrsubjectOfCh = ["Quantitaive","Verbal"]
      if courseTimeKind == K.RealtimeDatabase.normal
      {
        arrNumberOfCh = ["1) ","2)","3)","4)","5)","6)","7)","8)","9)","10)","11)","12)","13)","14)","15)","16)","17)","18)","19)","20)"]
        arrNumberOfWeek = ["first week","second week","third week","fourth week","fifth week","sixth week","Seventh week", "eighth week","ninth week","tenth week","eleventh week","Twelfth week"]
        
      }
      else
      {
        arrNumberOfCh = ["1) ","2)","3)","4)","5)","6)","7)","8)","9)","10)","11)","12)","13)","14)","15)","16)","17)","18)","19)","20)","21)","22)","23)","24)","25)","26)","27)","28)","29)","30)","31)","32)","33)","34)","35)","36)","37)","38)","39)","40)"]
        arrNumberOfWeek = ["first week","second week","third week","fourth week","fifth week","sixth week"]
      }
    }
  }
  
  
  //To:change  textField contents of PickerView
  @objc func textFieldDidChange(_ textField: UITextField) {
    
    if textField.tag == 100 {
      selectNumberOfCh.inputView = piker
      selectNumberOfCh.inputAccessoryView = toolBar
      numOfch = true
      numofWeek = false
      subjectch = false
      diff = false
      
    } else if textField.tag == 200
    {
      selectNumberOfWeek.inputView = piker
      selectNumberOfWeek.inputAccessoryView = toolBar
      numOfch = false
      numofWeek = true
      subjectch = false
      diff = false
      
    } else if textField.tag == 300
    {
      subjectOfCh.inputView = piker
      subjectOfCh.inputAccessoryView = toolBar
      numOfch = false
      numofWeek = false
      subjectch = true
      diff = false
      
    } else if textField.tag == 400
    {
      difficultyLevel.inputView = piker
      difficultyLevel.inputAccessoryView = toolBar
      numOfch = false
      numofWeek = false
      subjectch = false
      diff = true
    }
  }
  
  
  //Action DisMiss Button
  func setUpElements() {
    
    disMissButton.setTitle("Dismiss".localized,
                           for: .normal)
    disMissButton.layer.borderWidth = 0
    disMissButton.tintColor = .white
    disMissButton.layer.borderColor = CGColor.init(red: 0,
                                                   green: 0,
                                                   blue: 1,
                                                   alpha: 1)
    disMissButton.setTitleColor(.blue,
                                for: .normal)
  }
  
  
  //To: get TextField Event
  func getTextFieldEvent()
  {
    selectNumberOfCh.tag = 100
    selectNumberOfCh.addTarget(self,
                               action: #selector(self.textFieldDidChange(_:)), for: .editingDidBegin)
    
    selectNumberOfWeek.tag = 200
    selectNumberOfWeek.addTarget(self,
                                 action: #selector(self.textFieldDidChange(_:)), for: .editingDidBegin)
    
    subjectOfCh.tag = 300
    subjectOfCh.addTarget(self,
                          action: #selector(self.textFieldDidChange(_:)), for: .editingDidBegin)
    
    difficultyLevel.tag = 400
    difficultyLevel.addTarget(self,
                              action: #selector(self.textFieldDidChange(_:)), for: .editingDidBegin)
  }
  
  
  //Too: Check that all fields are filled in
  func validateFields() -> String? {
    
    if   selectNumberOfCh.text == "" ||
          selectNumberOfWeek.text == "" ||
          subjectOfCh.text == "" ||
          difficultyLevel.text == "" ||
          titleOfCh.text == ""
    {
      return "please fill in all fields.".localized
    }
    return nil
  }
  
  
  //To: determine number Of Picker Columns
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
    
  }
  
  //To: determine number Of Picker Rows
  func pickerView(_ pickerView: UIPickerView,
                  numberOfRowsInComponent component: Int) -> Int {
    
    if numofWeek
    {
      return arrNumberOfWeek.count
    }else if numOfch
    {
      return arrNumberOfCh.count
    }else if subjectch
    {
      return arrsubjectOfCh.count
    }else
    {
      return arrdifficultyLevel.count
    }
    
  }
  
  
  //To: fill the contents of the rows in pickerView
  func pickerView(_ pickerView: UIPickerView,
                  titleForRow row: Int,
                  forComponent component: Int) -> String?{
    
    if numofWeek
    {
      return arrNumberOfWeek[row]
    }else if numOfch
    {
      return arrNumberOfCh[row]
    }else if subjectch
    {
      return arrsubjectOfCh[row]
    }else
    {
      return arrdifficultyLevel[row]
    }
  }
  
  
  func pickerView(_ pickerView: UIPickerView,
                  didSelectRow row: Int,
                  inComponent component: Int) {
    if numofWeek
    {
      selectNumberOfWeek.text = arrNumberOfWeek[row]
      numOfWeekcurrentIndex = row
    }else if numOfch
    {
      selectNumberOfCh.text = arrNumberOfCh[row]
      numOfChcurrentIndex = row
    }else if subjectch
    {
      subjectOfCh.text = arrsubjectOfCh[row]
      subjectcurrentIndex = row
    }else
    {
      difficultyLevel.text = arrdifficultyLevel[row]
      diffcurrentIndex = row
    }
    
  }
  
  @objc func closePicker() {
    view.endEditing(true)
    
  }
  
  
  
  //MARK: - IBAction
  
  
  
  @IBAction func dismissedButtonTapped(_ sender: Any) {
    self.dismiss(animated: true,
                 completion: nil)
  }
  
  
  //To: set data in Firebace
  @IBAction func addBtn(_ sender: Any) {
    
    //validate
    let error = validateFields()
    if error != nil {
      K.getMsg(title:"Error!".localized,
               Msg: "Error In Validating Data".localized,
               context: self)
      
  }
  else
    {
      let chalId = UUID.init().uuidString
      let challengAttachment = ChallengAttachment( challengId : chalId,
                                                  numberOfCH: arrNumberOfCh[numOfChcurrentIndex],
                                                    titleOfCH:
                                                      self.titleOfCh.text!,
                                                    numberOfweek: arrNumberOfWeek[numOfWeekcurrentIndex],
                                                    difficultylevel: arrdifficultyLevel[diffcurrentIndex],
                                                    subjectOfCH: arrsubjectOfCh[subjectcurrentIndex],
                                                    cId: transferedCId,
                                                    isCompLeted: false)
      
      
      self.ref.child(challengAttachment.challengId).setValue(challengAttachment.toDictionary()) {Error, DataRef in
        
        if Error == nil
        {
          K.getMsg(title:"Nice Work".localized,
                   Msg:"Course Added Successfully".localized,
                   context: self){  result,
                                    error in
            if !error
            {
              self.dismiss(animated: true,
                           completion: nil)
              
            }
          }
        }else{
          print(Error.debugDescription)
        }
      }
    }
  }
  
}


