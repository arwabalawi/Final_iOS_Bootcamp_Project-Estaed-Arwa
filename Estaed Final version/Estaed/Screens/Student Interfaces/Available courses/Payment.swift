//
//  payment.swift
//  Estaed
//
//  Created by arwa balawi on 20/05/1443 AH.
//

import Foundation
import UIKit

class Payment : UIViewController{
  
  // MARK: - IBOtlets
  
  @IBOutlet weak var thankLabel: UILabel!
  @IBOutlet weak var check: UILabel!
  
  
  // MARK: - View controller lifecycle
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  
  //MARK: - IBAction
  
  
  //To: show the text label
  @IBAction func done(_ sender: Any) {
    
    check.text = "Your request has been successfully received. The request will be reviewed and confirmed within 12 hours".localized
    
    thankLabel.text = "Thank for trusting us".localized
    
  }
  
}
