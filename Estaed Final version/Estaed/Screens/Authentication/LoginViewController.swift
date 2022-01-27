//
//  LoginViewController.swift
//  EstaedUITests
//
//  Created by arwa balawi on 09/05/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase
import FirebaseCore

class LoginViewController: UIViewController,
                           UITextFieldDelegate {
  
  // MARK: - Properties
  
  var iconClick = false
  let imageicon = UIImageView()
  var user = User()
  
  
  // MARK: - IBOtlets
  
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var errorLabel: UILabel!
  @IBOutlet weak var forgatePassBtn: UIButton!
  @IBOutlet weak var newUserBtn: UIButton!
  
  
  
  // MARK: - View controller lifecycle
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    emailTextField.delegate = self
    passwordTextField.delegate = self
    setUpElements()
    
    imageicon.image = UIImage(named: "visibility")
    
    let contentView = UIView()
    contentView.addSubview(imageicon)
    
    contentView.frame = CGRect(x: 0, y: 0, width: UIImage(named: "visibility")!.size.width,height: UIImage(named: "visibility")!.size.height)
    
    imageicon.frame = CGRect(x: -10, y: 0, width: UIImage(named: "visibility")!.size.width,height: UIImage(named: "visibility")!.size.height)
    
    passwordTextField.rightView = contentView
    passwordTextField.rightViewMode = .always
    
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
    
    imageicon.isUserInteractionEnabled = true
    imageicon.addGestureRecognizer(tapGestureRecognizer)
  }
  
  
  //MARK: - Methods
  
  
  //To: Design label,textField and button By call Utilities class
  func setUpElements() {
    // Hide the error label
    errorLabel.isHidden = true
    // Style the element
    Utilities.styleTextField(textfield: emailTextField)
    Utilities.styleTextField(textfield: passwordTextField)
    Utilities.styleFilledButton(loginButton)
    Utilities.styleFilledButton(forgatePassBtn)
    Utilities.styleFilledButton(newUserBtn)
  }
  
  
  //To: Transfer to next textfield directly
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == emailTextField {
      passwordTextField.becomeFirstResponder()
    } else {
      //hide the keyboard
      view.endEditing(true)
    }
    return true
  }
  
  
  //To: action for eyes imge
  @objc func imageTapped(tapGestureRecognizer:UITapGestureRecognizer) {
    let tappedImage = tapGestureRecognizer.view as! UIImageView
    
    if iconClick {
      
      iconClick = false
      tappedImage.image = UIImage(named: "eye")
      passwordTextField.isSecureTextEntry = false
    }
    else {
       iconClick = true
      tappedImage.image = UIImage(named: "visibility")
      passwordTextField.isSecureTextEntry = true
    }
  }
  
  
  
  //MARK: - IBAction
  
  
  //To: Programmatically switch to another interface
  @IBAction func forgatePassword(_ sender: Any) {
    let forgatePassword = self.storyboard?.instantiateViewController(identifier: K.Storyboard.forgatePassword)
    
    self.view.window?.rootViewController = forgatePassword
    self.view.window?.makeKeyAndVisible()
  }
  
  
  
  //To : Programmatically switch to another interface
  @IBAction func haveAccount(_ sender: Any) {
    
    if let next  = storyboard?.instantiateViewController(identifier: K.Storyboard.signUpViewController) as? SignUpViewController{
      
      next.modalPresentationStyle = .fullScreen
      self.navigationController?.pushViewController(next,
                                                    animated: true)
    }
  }
  
  
  
  //To : Set data from Firebace
  @IBAction func loginTapped(_ sender: Any) {
    
    // Create cleaned versions of the text field
    let email = emailTextField.text!
    let password = passwordTextField.text!
    
    // signin in the user
    Auth.auth().signIn(withEmail: email,
                       password: password) { result,
                                             err in
      
      if err != nil {
        // Couldn't sign in
        self.errorLabel.text = err!.localizedDescription
        self.errorLabel.isHidden = false
      }
      else
      {
        // sign in successfully
        print("Finish Auth")
        Database.database().reference().child("users").child(result!.user.uid).getData()
        {
          error , Data in
          if let dictionary = Data.value as? NSDictionary , Data.exists(){
            
            print("Found User Data")
            self.user = User(value: dictionary)
            print("user Type : \(self.user.userType)")
            
            if self.user.userType == 0
            {
              // navigate to admin screens with keep on Navigation Controller bonding
              K.RealtimeDatabase.userId = result!.user.uid
              if let next = UIStoryboard(name: "Main",
                                         bundle: nil).instantiateViewController(identifier: K.Storyboard.ActivateCourseViewController)
                  as? ActivateCourseViewController{
                
                next.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(next,
                                                              animated: true)
              }
              
            }else if self.user.userType == 1
            {
              print("we are here ")
              
              //navigate to instructor screen with keep on Navigation Controller bonding
              K.RealtimeDatabase.userId = result!.user.uid
              
              if let next = UIStoryboard(name: "Main",
                                         bundle: nil).instantiateViewController(identifier: K.Storyboard.InstructorsCoursesTabelViewController)
                  as? InstructorsCoursesTabelViewController{
                
                next.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(next,
                                                              animated: true)
              }
              
            }else
            {
              //programmatically tabBar (call tabBar func we creat in constant class)
              K.RealtimeDatabase.studentId = (result?.user.uid)!
              K.navigateToUserScreen(context: self.navigationController!)
            }
          }
        }
      }
    }
  }
}

