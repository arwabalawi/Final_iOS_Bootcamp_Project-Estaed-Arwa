//
//  ForgatePasswordViewController.swift
//  Estaed
//
//  Created by arwa balawi on 23/06/1443 AH.
//

import UIKit
import Firebase


class ForgatePasswordViewController: UIViewController {
  
  
  @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    override func viewDidLoad() {
          super.viewDidLoad()
          setUpElements()
      }
    
    
    //MARK: -design label,textField and button By call Utilities class
    func setUpElements() {
      Utilities.styleFilledButton(saveBtn)
      Utilities.styleTextField(textfield: emailTextField)
    }
    
    
    //MARK: -func to send msg in email to change the password
    @IBAction func forgatePassword(_ sender: Any) {
      
      let auth = Auth.auth()
      auth.sendPasswordReset(withEmail: emailTextField.text!)
      {
        (error) in
        if error != nil {
          
          K.getMsg(title:"Error!".localized,Msg: "error while Getting Data".localized, context: self)
        return
        }
        
        K.getMsg(title:"Hurry".localized,Msg:"A password reset email has been sent!".localized, context: self)
      }
    }
    
    
    //MARK: -Programmatically switch to another interface
    @IBAction func dismissButton( sender: UIButton) {
      let loginViewController =
       storyboard?.instantiateViewController(identifier: K.Storyboard.loginViewController)
       
       view.window?.rootViewController = loginViewController
       view.window?.makeKeyAndVisible()
       
    }

  }


    


