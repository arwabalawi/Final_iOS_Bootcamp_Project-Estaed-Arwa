//
//  MyLectureCell.swift
//  Estaed
//
//  Created by arwa balawi on 06/06/1443 AH.
//

import UIKit

class MyLectureCell: UITableViewCell {
  
  // MARK: - Properties
  
  var url : String = ""
  
  
  // MARK: - IBOtlets
  
  
  @IBOutlet weak var lectureName: UILabel!
  @IBOutlet weak var lectureDate: UILabel!
  @IBOutlet weak var lectureTime: UILabel!
  @IBOutlet weak var joinBtn: UIButton!
  
  
  // MARK: - View controller lifecycle
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected,
                      animated: animated)
    
  }
  
  
  //MARK: - IBAction
  
  @IBAction func joinBtnTapped(_ sender: Any) {
    if !url.isEmpty
    {
      let myurl = URL(string:url)!
      if #available(iOS 10.0, *) {
        UIApplication.shared.open(myurl,
                                  options: [:],
                                  completionHandler: nil)
      } else {
        // Fallback on earlier versions
        UIApplication.shared.openURL(myurl)
      }
    }
  }
}
