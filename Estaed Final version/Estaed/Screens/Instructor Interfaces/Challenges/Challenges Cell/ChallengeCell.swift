//
//  ChallengeCell.swift
//  Estaed
//
//  Created by arwa balawi on 02/06/1443 AH.
//

import UIKit

class ChallengeCell: UITableViewCell {
  
  
  // MARK: - Properties
  
  
  var numberOfChallengeLabel: UILabel = {
    let label = UILabel(frame: CGRect(x: 10, y: 10,
                                      width: 200,
                                      height: 25))
    label.text = "Number Of Challenge:".localized
    return label
  }()

  var numberOfChallenge: UILabel = {
    let label = UILabel(frame: CGRect(x: 10,
                                      y: 30,
                                      width: 70,
                                      height: 25))
    
    return label
  }()
  
  var subjectOfChallengLabel : UILabel = {
    let label = UILabel(frame: CGRect(x: 10,
                                      y: 60,
                                      width: 200,
                                      height: 25))
    label.text = "Subject of challeng:".localized
    return label
  }()
  
  var subjectOfChalleng: UILabel = {
    let label = UILabel(frame: CGRect(x: 10,
                                      y: 80,
                                      width: 100,
                                      height: 25))
    
    return label
  }()
  
  var numberOfWeekLabel :UILabel = {
    let label = UILabel(frame: CGRect(x: 10,
                                      y: 110,
                                      width: 200,
                                      height:25 ))
    label.text = "number of week:".localized
    return label
  }()
  var numberOfWeek: UILabel = {
    let label = UILabel(frame: CGRect(x: 10,
                                      y: 130,
                                      width: 120,
                                      height: 25))
    
    return label
  }()
  
  var titleOfChallengeLabel : UILabel = {
    let label = UILabel(frame: CGRect(x: 230,
                                      y: 10,
                                      width: 200,
                                      height: 25))
    label.text = "Challenge title:".localized
    return label
  }()
  
  var titleOfChallenge: UILabel  = {
    let label = UILabel(frame: CGRect(x: 230,
                                      y: 30,
                                      width: 200,
                                      height: 25))
    
    return label
  }()
  var difficultyLevelLabel : UILabel = {
    let label = UILabel(frame: CGRect(x: 230,
                                      y: 60,
                                      width: 200,
                                      height: 25))
    label.text = "difficulty Level:".localized
    return label
  }()
  
  var difficultyLevel: UILabel = {
    let label = UILabel(frame: CGRect(x: 230,
                                      y: 80,
                                      width: 50,
                                      height: 25))
    
    return label
  }()
  var btnChallengDetails: UIButton = {
    
    let btn = UIButton(frame: CGRect(x: 200,
                                     y: 110,
                                     width: 150,
                                     height: 25))
    btn.backgroundColor = .purple
    
    btn.setTitle("Challenge Details".localized,
                 for: .normal)
    
    btn.tintColor = .systemBlue
    btn.setTitleColor(.systemBlue,
                      for: .normal)
    return btn
  }()
  
  
  var myCellDelegate : MyCellDelegate?
  
  
  
  //MARK: - View controller lifecycle
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
  
  override func setSelected(_ selected: Bool,
                            animated: Bool) {
    super.setSelected(selected,
                      animated: animated)
  }
  
  
  //MARK: - Methode
  
  
  
  //To: action the butoon challenge details
  @objc func btnChallengDetails(_ Sender : UIButton)
  {
    myCellDelegate?.didPressButton(Sender.tag)
  }
  
  
  func initCell(model : ChallengAttachment)
  {
    self.contentView.addSubview(numberOfChallengeLabel)
    self.contentView.addSubview(numberOfChallenge)
    self.contentView.addSubview(numberOfWeekLabel)
    self.contentView.addSubview(numberOfWeek)
    self.contentView.addSubview(difficultyLevelLabel)
    self.contentView.addSubview(difficultyLevel)
    self.contentView.addSubview(subjectOfChallengLabel)
    self.contentView.addSubview(subjectOfChalleng)
    self.contentView.addSubview(titleOfChallengeLabel)
    self.contentView.addSubview(titleOfChallenge)
    self.contentView.addSubview(btnChallengDetails)
    
    self.btnChallengDetails.addTarget(self,
                                      action: #selector(btnChallengDetails(_:)),
                                      for: .touchUpInside)
    self.numberOfChallenge.text = model.numberOfCH
    self.numberOfWeek.text = model.numberOfweek
    self.difficultyLevel.text = model.difficultylevel
    self.subjectOfChalleng.text = model.subjectOfCH
    self.titleOfChallenge.text = model.titleOfCH
  }
  
  
}
