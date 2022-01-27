//
//  myLectureViewController.swift
//  Estaed
//
//  Created by arwa balawi on 06/06/1443 AH.
//

import UIKit
import Firebase

class MyLectureViewController: UIViewController {
  
  
  // MARK: - Properties
  
  var ref : DatabaseReference!
  var myLectureModelList = [Lecture]()
  var courseId = ""
  
  
  
  // MARK: - IBOtlets
  
  
  @IBOutlet weak var tableViewMyLecture: UITableView!
  
  
  // MARK: - View controller lifecycle
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      tableViewMyLecture.register(UINib(nibName: "MyLectureCell",
                                        bundle: nil),
                                        forCellReuseIdentifier: "MyLectureCell")
      tableViewMyLecture.delegate = self
      tableViewMyLecture.dataSource = self
       
      ref = Database.database().reference().child(K.RealtimeDatabase.lectures).child(courseId)
     print("lecture course ID : \(courseId)")
    getData()
  }
  
  
  
  //MARK: - Methods
  
  
  
  //To: git data from firebase
  func getData()
  {
    
    if !self.myLectureModelList.isEmpty
    {
      self.myLectureModelList.removeAll()
    }
    self.ref.observe(.value, with: {
                       dataSnapShot in
    
        if let dictionary =  dataSnapShot.value as? NSDictionary,
                                              dataSnapShot.exists(){
        for (_,v) in dictionary {
          let dictionary = v as! NSDictionary
          self.myLectureModelList.append(Lecture(value: dictionary))
        }
      }
      self.tableViewMyLecture.reloadData()
    })
  }
}



//MARK: - extension


extension MyLectureViewController : UITableViewDelegate,
                                    UITableViewDataSource {
  
  //number Of Rows In Section
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    
    return self.myLectureModelList.count
  }
  
  
  //for content cell For Row
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: K.Storyboard.myLectureCell,
                                             for: indexPath) as? MyLectureCell
    
    cell!.lectureName.text =
      self.myLectureModelList[indexPath.row].lectureName
    cell!.lectureDate.text =
      self.myLectureModelList[indexPath.row].lectureDate
    cell!.lectureTime.text =
      self.myLectureModelList[indexPath.row].lectureTime
      cell!.url = self.myLectureModelList[indexPath.row].lectureURL
    
      return cell!
   
  }

}
  
  



  
 
