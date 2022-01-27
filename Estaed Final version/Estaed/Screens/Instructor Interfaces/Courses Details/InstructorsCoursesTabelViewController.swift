//
//  TeacherCourses.swift
//  Estaed
//
//  Created by arwa balawi on 10/05/1443 AH.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class InstructorsCoursesTabelViewController : UIViewController {
  
  
  // MARK: - Properties
  
  var courses = [Course]()
  var ref: DatabaseReference!
  var currentCourseindex = -1
  
  
  // MARK: - IBOtlets
  
  @IBOutlet var tableViewCD : UITableView!
  
  
  // MARK: - View controller lifecycle
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //hide back button come frome previous interface
    navigationItem.hidesBackButton = true
    
    tableViewCD.register(UINib(nibName: "TableViewCell",
                               bundle: nil),
                         forCellReuseIdentifier: "TableViewCell")
    
    tableViewCD.delegate = self
    tableViewCD.dataSource = self
    ref = Database.database().reference().child("courses").child(K.RealtimeDatabase.userId)
    getCourses()
  }
  
  
  
  //MARK: - Methods
  
  
  
  func getCourses()
  {
    self.ref.observe(.value) { dataSnapShot in
      if !self.courses.isEmpty
      {
        self.courses.removeAll()
      }
      if let dictionary =  dataSnapShot.value as? NSDictionary,
         dataSnapShot.exists(){
        for (_,v) in dictionary {
          let dictionary = v as! NSDictionary
          self.courses.append(Course(value: dictionary))
        }
        self.tableViewCD.reloadData()
      }
    }
  }
  
  
  
  //MARK: - IBAction
  
  
  
  
  @IBAction func logoutBtn(_ sender: Any) {
    
    try? Auth.auth().signOut()
    
    if let next = storyboard?.instantiateViewController(identifier: K.Storyboard.LandingViewController) as? LandingViewController{
      
      next.modalPresentationStyle = .fullScreen
      self.navigationController?.pushViewController(next,
                                                    animated: true)
    }
  }
  
  //To: Programmatically switch to another interface with keep on Navigation Controller bonding
  @IBAction func AddBtn(_ sender: Any) {
    
    if let next = storyboard?.instantiateViewController(identifier: K.Storyboard.InstructorsAddCourse) as? InstructorsAddCourse {
      
      next.modalPresentationStyle = .fullScreen
      self.navigationController?.pushViewController(next,
                                                    animated: true)
    }
  }
}



//MARK: - extension


extension InstructorsCoursesTabelViewController : UITableViewDelegate,
                                                  UITableViewDataSource,
                                                  newCellDelegate {
  func didPressButton(_ tag: Int, _ Sender: UIButton) {
    
    if Sender.currentTitle == "List of challenges"
    {
      //Too: go to Challenges Table View Controller screen
      let story = UIStoryboard(name: "Main",
                               bundle: nil)
      
      if let next = story.instantiateViewController(identifier: K.Storyboard.challengesTableViewController) as? ChallengesTableViewController{
        K.RealtimeDatabase.courseName = self.courses[tag].courseName
        K.RealtimeDatabase.courseTimeKind = self.courses[tag].courseTimeKind
        next.modalPresentationStyle = .fullScreen
        next.transferedCId = self.courses[tag].courseId
        self.navigationController?.pushViewController(next,
                                                      animated: true)
      }
      
    }else if Sender.currentTitle == "List of lectures"
    {
      //go to Lecture Table View Controller screen
      let story = UIStoryboard(name: "Main",
                               bundle: nil)
      
      if let next = story.instantiateViewController(identifier: K.Storyboard.lectureTableViewController) as? LectureTableViewController{
        
        next.modalPresentationStyle = .fullScreen
        next.courseId = self.courses[tag].courseId
        self.navigationController?.pushViewController(next,
                                                      animated: true)
        
      }
    } else
    {
      //go to Course Update View Controller screen
      let courseDetails = self.courses[tag]
      
      let _ : UIStoryboard = UIStoryboard(name: "Main",
                                          bundle: nil)
      
      if let Manage = storyboard?.instantiateViewController(identifier: K.Storyboard.courseUpdateViewController) as? CourseUpdateViewController{
        
        Manage.courseDetails = courseDetails
        Manage.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(Manage,
                                                      animated: true)
      }
    }
    
  }
  
  

  
  
  //for content cell For Row
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: K.Storyboard.TableViewCell, for: indexPath) as? TableViewCell
    
    cell?.courseName.text = self.courses[indexPath.row].courseName
    cell?.courseTimeKind.text = self.courses[indexPath.row].courseTimeKind
    cell?.courseContents.text = self.courses[indexPath.row].courseContents
    cell?.coursePrice.text = self.courses[indexPath.row].coursePrice
    cell?.courseTime.text = self.courses[indexPath.row].courseDate
    
    cell?.btnManageCourse.tag = indexPath.row
    self.currentCourseindex = indexPath.row
    cell?.btnChallenge.tag = indexPath.row
    cell?.btnLectures.tag = indexPath.row
    cell?.myCellDelegate = self
    
    return cell!
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.currentCourseindex = indexPath.row
  }
  //navigate to another screen with keep on Navigation Controller bonding
  
  
  
  //number Of Rows In Section
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    
    return self.courses.count
  }
  
  
  //number Of Section
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
}
