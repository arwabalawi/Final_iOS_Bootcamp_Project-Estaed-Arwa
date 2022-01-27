//
//  ActivateCourseViewController.swift
//  Estaed
//
//  Created by arwa balawi on 30/05/1443 AH.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth


class ActivateCourseViewController: UIViewController {
  
  // MARK: - Properties
  
  
  var studentCourseModelList = [StudentCourse]()
  var ref: DatabaseReference!
  
  
  
  // MARK: - IBOtlets
  
  
  @IBOutlet weak var tableViewActivate: UITableView!
  
  
  
  //MARK: - View controller lifecycle
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //hide back button come frome previous interface
    navigationItem.hidesBackButton = true
    
    tableViewActivate.register(UINib(nibName: "ActivateCourseVCCell",
                                     bundle: nil),
                               forCellReuseIdentifier: "ActivateCourseVCCell")
    
    tableViewActivate.delegate = self
    tableViewActivate.dataSource = self
    ref = Database.database().reference().child("StudentCourses")
    getData()
  }
  
  
  //MARK: - Methods
  
  
  
  func getData()
  {
    self.ref.getData { error,
                       Data in
      
      if !self.studentCourseModelList.isEmpty
      {
        self.studentCourseModelList.removeAll()
      }
      if let dictionary =  Data.value as? NSDictionary{
        for (_,value) in dictionary {
          let v1 = value as! NSDictionary
          for (_,v) in v1 {
            
            let dictionary = v as! NSDictionary
            let model = StudentCourse(value: dictionary)
            if model.isPaid == false
            {
              self.studentCourseModelList.append(model)
            }
            
          }
        }
      }
      self.tableViewActivate.reloadData()
    }
  }
  
  
  
  
  //MARK: - IBAction
  
  
  
  @IBAction func logOut(_ sender: Any) {
    
    try? Auth.auth().signOut()
    
    if let next = storyboard?.instantiateViewController(identifier: K.Storyboard.LandingViewController) as? LandingViewController{
      
      next.modalPresentationStyle = .fullScreen
      self.navigationController?.pushViewController(next,
                                                    animated: true)
    }
  }
}




//MARK: - extension



extension ActivateCourseViewController : UITableViewDelegate,
                                         UITableViewDataSource {
  
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    
    return self.studentCourseModelList.count
  }
  
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "ActivateCourseVCCell",
                                             for: indexPath) as? ActivateCourseVCCell
    
    cell?.courseIdCell.text =
      self.studentCourseModelList[indexPath.row].courseId
    cell?.studentIdCell.text =
      self.studentCourseModelList[indexPath.row].studentId
    cell!.model =  self.studentCourseModelList[indexPath.row]
    
    return cell!
  }
  
}








