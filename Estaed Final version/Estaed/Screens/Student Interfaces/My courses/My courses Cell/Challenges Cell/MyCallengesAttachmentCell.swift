//
//  myCallengesCell.swift
//  Estaed
//
//  Created by arwa balawi on 06/06/1443 AH.
//

import UIKit
import Firebase
class MyCallengesAttachmentCell: UITableViewCell {
  
  // MARK: - Properties
  
  var challingeId = ""
  var myCellDelegate : newCellDelegate?
  
  
  // MARK: - IBOtlets
  
  @IBOutlet weak var numOfWeekLabel: UILabel!
  @IBOutlet weak var numberOfCh: UILabel!
  @IBOutlet weak var titleOfCh: UIButton!
  @IBOutlet weak var completed: UILabel!
  @IBOutlet weak var subjectOfCh: UILabel!
  @IBOutlet weak var difficultyOfCh: UILabel!
  @IBOutlet weak var btnHeart : UIButton!
  @IBOutlet weak var btnDetails: UIButton!
  
  
  
  // MARK: - View controller lifecycle
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    
    super.setSelected(selected,
                      animated: animated)
  }
  
  
  //MARK: -IBAction
  
  
  @IBAction func didbtnTapped(_ sender: UIButton) {
    
    myCellDelegate?.didPressButton(sender.tag,sender)
  }
  
  
  @IBAction func btnHeartTapped(_ sender : UIButton) {
    
      myCellDelegate?.didPressButton(sender.tag, sender)
  }
  
}
