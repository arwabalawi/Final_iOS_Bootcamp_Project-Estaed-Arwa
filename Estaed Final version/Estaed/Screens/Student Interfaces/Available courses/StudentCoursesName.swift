//
//  StudentCoursesName.swift
//  Estaed
//
//  Created by arwa balawi on 29/05/1443 AH.
//

import UIKit
import Firebase

class StudentCoursesName: UIViewController {
  
  // MARK: - Properties
  
  let story = UIStoryboard(name: "Main",
                           bundle: nil)
  
  var courseModelList = [Course]()
  var nonReservedCourses = [Course]()
  var coursesIdList = [String]()
  
  
  
  // MARK: - IBOtlets
  
  @IBOutlet weak var tableView: UITableView!
  
  
  // MARK: - View controller lifecycle
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //hide back button come frome previous interface
    navigationItem.hidesBackButton = true
    
    tableView.dataSource = self
    tableView.register(UINib(nibName: "AvailableCourseCellTableViewCell",
                             bundle: nil),
                       forCellReuseIdentifier: "avilableCourseCell")
    getData()
  }
  
  
  
  //MARK: - Methods
  
  
  //To: func to get data frome Firebace
  func getData()
  {
    Database.database().reference().child("StudentCourses")
      .child(K.RealtimeDatabase.studentId).observe(.value, with: {  DataSnapShot in
        
        if let dictionary = DataSnapShot.value as? NSDictionary,
           DataSnapShot.exists()
        {
          for (key ,_) in dictionary
          {
            self.coursesIdList.append(key as! String)
          }
        }
      })
    
    Database.database().reference().child("courses").observe(.value)
    { DataSnapShot in
      
      if let dictionary = DataSnapShot.value as? NSDictionary,DataSnapShot.exists()
      {
        for (_ , v) in dictionary{
          for (_ , v1) in v as! NSDictionary
          {
            let  value = v1 as! NSDictionary
            let model = Course(value: value)
            self.courseModelList.append(model)
          }
        }
        
        for item in self.courseModelList
        {
          var isFound = false
          for id in self.coursesIdList
          {
            if id == item.courseId
            {
              isFound = true
            }
          }
          if isFound == false
          {
            self.nonReservedCourses.append(item)
          }
        }
        self.tableView.reloadData()
      }
    }
  }
}



//MARK: - extension


extension StudentCoursesName : UITableViewDataSource,
                               MyCellDelegate {
  
  //action the details button in cell
  func didPressButton(_ tag: Int)
  {
    //Programmatically switch to another interface with keep on Navigation Controller bonding
    if let next = self.story.instantiateViewController(withIdentifier: K.Storyboard.studentCourseDetails) as? StudentCourseDetails
    {
      next.model = self.nonReservedCourses[tag]
      next.modalPresentationStyle = .fullScreen
      self.navigationController?.pushViewController(next,
                                                    animated: true)
    }
  }
  
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  //number Of Rows In Section
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    
    return self.nonReservedCourses.count
  }
  
  //content cell For Row
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "avilableCourseCell") as? AvailableCourseCellTableViewCell
    
    cell!.configre(value: self.nonReservedCourses[indexPath.row])
    cell!.delegate = self
    cell!.btnDetails.tag = indexPath.row
    return cell!
  }
  
  
}

