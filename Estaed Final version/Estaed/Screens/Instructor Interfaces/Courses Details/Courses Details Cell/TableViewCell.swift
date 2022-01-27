//
//  TableViewCell.swift
//  Estaed
//
//  Created by arwa balawi on 11/05/1443 AH.
//

import UIKit
import Foundation

class TableViewCell: UITableViewCell {
  
  // MARK: - Properties
  
  var myCellDelegate : newCellDelegate?
  // MARK: - IBOtlets
  
  @IBOutlet var btnManageCourse : UIButton!
  @IBOutlet var btnChallenge: UIButton!
  @IBOutlet weak var btnLectures: UIButton!
  @IBOutlet var courseName : UILabel!
  @IBOutlet var courseContents : UILabel!
  @IBOutlet var courseTime : UILabel!
  @IBOutlet var coursePrice : UILabel!
  @IBOutlet  var courseTimeKind : UILabel!
  
 
  

  // MARK: - View controller lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
  
  override func setSelected(_ selected: Bool,
                            animated: Bool) {
    
    super.setSelected(selected,
                      animated: animated)
  }
  
 
  // MARK: - IBAction
  
  
  
  @IBAction func btnUpdateCourse(_ Sender : UIButton)
  {
    myCellDelegate?.didPressButton(Sender.tag,Sender)
  }
  
  
  @IBAction func btnChallenge(_ Sender: UIButton)
  {
    myCellDelegate?.didPressButton(Sender.tag,Sender)
  }
  
  
  @IBAction func btnLectures(_ Sender: UIButton)
  {
    myCellDelegate?.didPressButton(Sender.tag,Sender)
    
  }
  
}

