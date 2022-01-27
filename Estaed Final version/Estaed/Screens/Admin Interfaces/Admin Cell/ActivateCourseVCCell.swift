//
//  ActivateCourseVCCell.swift
//  Estaed
//
//  Created by arwa balawi on 30/05/1443 AH.


import UIKit
import FirebaseDatabase
class ActivateCourseVCCell: UITableViewCell {
  
  // MARK: - Properties
  
  
  var model =  StudentCourse()
  
  
  // MARK: - IBOtlets
  
  @IBOutlet weak var studentIdCell: UILabel!
  @IBOutlet weak var courseIdCell: UILabel!
  @IBOutlet weak var paidBtn: UIButton!
  
  
  
  //MARK: - View controller lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
  
  
  override func setSelected(_ selected: Bool,
                            animated: Bool) {
    
    super.setSelected(selected,
                      animated: animated)
    
  }
  
  
  
  //MARK: - IBAction
  @IBAction func paidBtn(_ sender: Any) {
    
    model.isPaid = true
    Database.database().reference().child("StudentCourses").child(model.studentId).child(model.courseId).setValue(model.toDictionary())
    paidBtn.backgroundColor = UIColor.init(red: 11/255,
                                           green: 70/255,
                                           blue: 25/255,
                                           alpha: 1)
    
  }
}
