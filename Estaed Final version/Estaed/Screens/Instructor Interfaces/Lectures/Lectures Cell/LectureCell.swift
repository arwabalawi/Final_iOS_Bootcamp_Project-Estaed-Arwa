//
//  LectureCell.swift
//  Estaed
//
//  Created by Mahmoud Fayez on 04/01/2022.
//

import UIKit

class LectureCell: UITableViewCell{
  
  // MARK: - IBOtlets
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var urlLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  
  
  //MARK: - View controller lifecycle
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
  
  override func setSelected(_ selected: Bool,
                            animated: Bool) {
    super.setSelected(selected,
                      animated: animated)
    
  }
  
}
