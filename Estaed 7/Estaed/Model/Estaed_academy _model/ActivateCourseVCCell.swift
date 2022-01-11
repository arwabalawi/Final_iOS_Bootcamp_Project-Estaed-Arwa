//
//  ActivateCourseVCCell.swift
//  Estaed
//
//  Created by arwa balawi on 30/05/1443 AH.


import UIKit
import FirebaseDatabase
class ActivateCourseVCCell: UITableViewCell {
  
  
  @IBOutlet weak var studentIdCell: UILabel!
  
  @IBOutlet weak var courseIdCell: UILabel!
  
  @IBOutlet weak var paidBtn: UIButton!
  
  
  @IBAction func paidBtn(_ sender: Any) {
   // self.paidBtn = true
    Database.database().reference().child(studentIdCell.text!).child("isPaid").setValue("true")
  }
  
  
  
  

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}