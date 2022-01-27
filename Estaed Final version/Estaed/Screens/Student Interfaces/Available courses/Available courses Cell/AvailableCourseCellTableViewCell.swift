//
//  AvailableCourseCellTableViewCell.swift
//  Estaed
//
//  Created by arwa balawi on 18/06/1443 AH.
//

import UIKit

class AvailableCourseCellTableViewCell: UITableViewCell {
  
  // MARK: - Properties
  
  var delegate : MyCellDelegate!
  
  
  // MARK: - IBOtlets
  
  @IBOutlet weak var courseName: UILabel!
  @IBOutlet weak var coursePrise: UILabel!
  @IBOutlet weak var courseKind: UILabel!
  @IBOutlet weak var btnDetails: UIButton!
  
  
  
  // MARK: - View controller lifecycle
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected,
                      animated: animated)
    
  }
  
  
  
  //MARK: - Methods
  
  
  func configre(value : Course?)
  {
    if value != nil
    {
      courseName.text = value?.courseName
      courseKind.text = value?.courseTimeKind
      coursePrise.text = value?.coursePrice
    }
  }
  
  
  //MARK: - IBAction
  
  @IBAction func didbtnTapped(_ sender: UIButton) {
    delegate.didPressButton(sender.tag)
  }
  
}
