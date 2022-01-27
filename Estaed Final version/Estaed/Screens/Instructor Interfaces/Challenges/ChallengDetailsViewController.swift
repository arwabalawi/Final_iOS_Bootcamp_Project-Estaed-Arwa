//
//  ChallengDetailsViewController.swift
//  Estaed
//
//  Created by arwa balawi on 24/05/1443 AH.
//
import Foundation
import UIKit
import FirebaseDatabase
import Firebase
import FirebaseCore

class ChallengDetailsViewController: UIViewController {
  
  // MARK: - Properties
  
  var ref : DatabaseReference!
  var transferedCId = ""
  var challingeId = ""
  
  
  // MARK: - IBOtlets
  
  
  @IBOutlet weak var quistionOfChalleng: UITextField!
  @IBOutlet weak var answerA: UITextField!
  @IBOutlet weak var answerB: UITextField!
  @IBOutlet weak var answerC: UITextField!
  @IBOutlet weak var answerD: UITextField!
  @IBOutlet weak var correctAnswer: UITextField!
  @IBOutlet weak var solutionMethod: UITextField!
  @IBOutlet weak var doneBtn: UIButton!
  @IBOutlet weak var disMissButton: UIButton!
  
  
  // MARK: - View controller lifecycle
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    ref = Database.database().reference()
  }
  
  
  //MARK: - Methods
  
  
  func setUpElements() {
    disMissButton.setTitle("Dismiss",
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
  
  
  //To: Check that all fields are filled in
  func validateFields() -> String? {
    
    if  quistionOfChalleng.text == "" ||
          answerA.text == "" ||
          answerB.text == "" ||
          answerC.text == "" ||
          answerD.text == "" ||
          correctAnswer.text == "" ||
          solutionMethod.text == ""
    {
      return "please fill in all fields.".localized
    }
    return nil
  }
  
  
  
  //MARK: - IBAction
  
  
  
  @IBAction func dismissedButtonTapped(_ sender: Any) {
    self.dismiss(animated: true,
                 completion: nil)
  }
  
  
  //To:set data on Firebace
  @IBAction func doneBtn(_ sender: Any) {
    
    //Too: validate
    let error = validateFields()
    if error != nil {
      K.getMsg(title:"Error!".localized,
               Msg: "Error In Validating Data".localized,
               context: self)
    }
    else
    {
      let chalDId = UUID.init().uuidString
      
      let challengDetailsModelList =
        ChallengDetail(challengDetID:
                        chalDId,
                       quistiontOfCH:self.quistionOfChalleng.text!,
                       answersA:self.answerA.text!,
                       answerB: self.answerB.text!,
                       answersC:self.answerC.text!,
                       answersD: self.answerD.text!,
                       correctAnswer: self.correctAnswer.text!,
                       solutionMethod: self.solutionMethod.text!,
                       ChallingeId : self.challingeId)
      
      self.ref.child("ChallingeDetails").child(self.challingeId)  .setValue(challengDetailsModelList.toDictionary()) {Error, DataRef in
        
        if Error == nil
        {
          K.getMsg(title:"Nice Work".localized,
                   Msg: "Course Added Successfully".localized,
                   context: self){  result, error in
            if !error
            {
              self.dismiss(animated: true, completion: nil)
            }
          }
        }else {
          print(Error.debugDescription)
        }
      }
    }
  }
  
}
