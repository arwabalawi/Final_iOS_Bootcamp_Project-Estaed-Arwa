//
//  Constant.swift
//  Estaed
//
//  Created by arwa balawi on 11/05/1443 AH.
//


import UIKit

struct K {

struct RealtimeDatabase {
  static let crash = "Crash"
  static let normal = "Normal"
  static let tahsely =  "Tahsely"
  static let qudrat = "Qudrat"
  static var userId = ""
  static var studentId = ""
  static var courseId = ""
  static let courses = "courses"
  static let challenge = "challenge"
  static let lectures = "Lectures"
  static var courseName = ""
  static var courseTimeKind = ""
  }
  
  
    static func getMsg(title: String,
                       Msg: String,
                       context: UIViewController)
    {
      let alert = UIAlertController(title: title,
                                      message: Msg,
                                      preferredStyle: .alert)
      
      let dismiss = UIAlertAction(title: "Dismiss".localized,
                                  style: .cancel)
      {  DismissAction in
            
        print("Dismiss Done".localized)
          
        }
       
        alert.addAction(dismiss)
      
        context.present(alert, animated: true) {
           
          print("Alert Start".localized)
        }
    }
  
    
    typealias handler = (_ result : String,
                         _ error :Bool)-> Void
        
  static func getMsg(title: String,
                     Msg: String,
                     context: UIViewController,
                     callBack:@escaping handler) {
    
            var action = ""
            let alert = UIAlertController(title: title,
                                          message: Msg,
                                          preferredStyle: .alert)
    
            let dismiss = UIAlertAction(title: "Dismiss".localized,
                                        style: .cancel)
            {  DismissAction in
                
                action = "Dismiss"
                print(action)
                callBack(action,false)
            }
           
            alert.addAction(dismiss)
          
            context.present(alert, animated: true) {
              print("Alert Start".localized)
            }
        }
  
  
  struct Storyboard {
    
  static let signUpViewController = "SignUp"
  static let loginViewController = "LogIn"
  static let courseUpdateViewController = "courseManage"
  static let lectureTableViewController = "LectureTableViewController"
  static let challengesTableViewController = "Challenges"
  static let homViewController = "HomViewController"
  static let studentTimeKindViewController = "StudentTimeKindViewController"
  static let studentChallengAttachmentVC = "StudentChallengAttachmentVC"
  static let studentCourseDetails = "StudentCourseDetails"
  static let myLecture = "myLectureViewController"
  static let myLectureCell = "MyLectureCell"
  static let forgatePassword = "ForgatePasswordViewController"
  static let studentDetailsChallengeVC = "StudentDetailsChallengeVC"
  static let ActivateCourseViewController = "ActivateCourseViewController"
  static let InstructorsCoursesTabelViewController = "Instructors"
  static let ChallengDetailsViewController = "ChallengDetails"
  static let InstructorsAddCourse = "InstructorsAddCourse"
  static let TableViewCell = "TableViewCell"
  static let ChallengAttachmentViewController = "courseAttatch"
  static let LectureViewController = "Lecture"
  static let MyCourseCell = "MyCourseCell"
  static let avilableCourseCell = "avilableCourseCell"
  static let payment = "payment"
  static let EditProfileViewController = "EditProfileViewController"
  static let ChallengeCell = "myCell"
  static let LectureCell = "LectureCell"
  static let LandingViewController = "LandingViewController"
    
  }
  
  
  static func navigateToUserScreen(context : UINavigationController)
  {
    let studentCoursesName = UIStoryboard(name: "Main",
                                          bundle: nil)
    .instantiateViewController(identifier: "StudentCoursesName") as! StudentCoursesName

    let myCourseViewController = UIStoryboard(name: "Main",
                                              bundle: nil)
    .instantiateViewController(identifier: "MyCourseViewController") as! MyCourseViewController
    
    let myFavoraitViewController = UIStoryboard(name: "Main",
                                                bundle: nil)
    .instantiateViewController(identifier: "MyFavoraitViewController") as! MyFavoraitViewController
    
    let profileStudentViewController = UIStoryboard(name: "Main",
                                                    bundle: nil)
    .instantiateViewController(identifier: "ProfileStudentViewController") as! ProfileStudentViewController
    
    studentCoursesName.title = "Home".localized
    myCourseViewController.title = "My Courses".localized
    myFavoraitViewController.title = "Favorait challenge".localized
    profileStudentViewController.title = "Profile".localized

    
    let tabBar = UITabBarController()
    tabBar.setViewControllers([
      studentCoursesName,
      myCourseViewController,
      myFavoraitViewController,
      profileStudentViewController
    
    ], animated: false)
    guard let  items = tabBar.tabBar.items else{return}

    items[0].image = UIImage(systemName: "house")
    items[1].image = UIImage(systemName: "slider.horizontal.3")
    items[2].image = UIImage(systemName: "heart.fill")
    items[3].image = UIImage(systemName: "person")
    tabBar.navigationItem.hidesBackButton = true
    context.pushViewController(tabBar,
                               animated: false)
  }
  
}



