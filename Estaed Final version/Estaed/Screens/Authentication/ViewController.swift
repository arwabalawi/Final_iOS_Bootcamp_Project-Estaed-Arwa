//
//  ViewController.swift
//  Estaed
//
//  Created by arwa balawi on 09/05/1443 AH.
//

import UIKit

class LandingViewController: UIViewController {
  
  // MARK: - IBOtlets
  
  @IBOutlet weak var SignUpButton: UIButton!
  @IBOutlet weak var LoginButton: UIButton!
  //To:language Segment Control
  @IBOutlet weak var languageSegmentControl: UISegmentedControl! {
    didSet
    {
      if let lang = UserDefaults.standard.string(forKey: "currentLanguage")
      {
        switch lang {
        case "ar":
          languageSegmentControl.selectedSegmentIndex = 0
          UIView.appearance().semanticContentAttribute = .forceLeftToRight
          
        case "en":
          languageSegmentControl.selectedSegmentIndex = 1
          UIView.appearance().semanticContentAttribute = .forceLeftToRight
          
        default:
          let localLang = Locale.current.languageCode
          if localLang == "en"{
            languageSegmentControl.selectedSegmentIndex = 1
          }
          else{
            languageSegmentControl.selectedSegmentIndex = 0
          }
        }
      }else {
        let localLang = Locale.current.languageCode
        UserDefaults.standard.setValue([localLang], forKey: "AppleLanguage")
        
        if localLang == "en"
        { languageSegmentControl.selectedSegmentIndex = 0
          
        }else{
          languageSegmentControl.selectedSegmentIndex = 1
        }
      }
    }
  }
  
  // MARK: - View controller lifecycle
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpElements()
    
    navigationItem.hidesBackButton = true
  }
  
  
  //MARK: - Methods
  
  
  //To: design label,textField and button By call Utilities class
  func setUpElements() {
    Utilities.styleFilledButton(SignUpButton)
    Utilities.styleFilledButton(LoginButton)
  }
  
  
  
  //MARK: - IBAction
  
  
  //To:Programmatically switch to another interface with keep on Navigation Controller bonding
  @IBAction func logInTapped(_ sender: Any) {
    
    if let next  = storyboard?.instantiateViewController(identifier: K.Storyboard.loginViewController) as? LoginViewController{
      
      next.modalPresentationStyle = .fullScreen
      self.navigationController?.pushViewController(next,
                                                    animated: true)
    }
  }
  
  
  //To: Programmatically switch to another interface with keep on Navigation Controller bonding
  @IBAction func signUpTapped(_ sender: Any) {
    
    if let next  = storyboard?.instantiateViewController(identifier: K.Storyboard.signUpViewController) as? SignUpViewController{
      
      next.modalPresentationStyle = .fullScreen
      self.navigationController?.pushViewController(next,
                                                    animated: true)
    }
  }
  
  
  
  //To: Change language by segmentControl
  @IBAction func languageSegmentControl(_ sender: UISegmentedControl)
  {
    if let lang = sender.titleForSegment(at: sender.selectedSegmentIndex)?.lowercased()
    {
      UserDefaults.standard.setValue(lang, forKey: "currentLanguage")
      Bundle.setLanguage(lang)
      
      let storyboard = UIStoryboard.init(name: "Main",
                                         bundle: nil)
      
      if let windowScane = UIApplication.shared.connectedScenes.first as? UIWindowScene,
         let sceneDelegate = windowScane.delegate as? SceneDelegate
      {
        sceneDelegate.window?.rootViewController =
          storyboard.instantiateInitialViewController()
      }
    }
  }
}
