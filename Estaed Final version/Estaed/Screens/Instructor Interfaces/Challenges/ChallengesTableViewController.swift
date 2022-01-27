//
//  ChallengesViewController.swift
//  Estaed
//
//  Created by arwa balawi on 23/05/1443 AH.
//

import UIKit
import FirebaseDatabase

class ChallengesTableViewController: UIViewController {
  
  
  // MARK: - Properties
  
  var challengAttachmentModelList = [ChallengAttachment]()
  var ref: DatabaseReference!
  var transferedCId = ""
  
  
  
  // MARK: - IBOtlets
  
  
  @IBOutlet weak var tableViewCH: UITableView!
  
  
  
  // MARK: - View controller lifecycle
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableViewCH.register(ChallengeCell.self,
                         forCellReuseIdentifier: "myCell")
    tableViewCH.delegate = self
    tableViewCH.dataSource = self
    
    ref = Database.database().reference()
    getData()
  }
  
  
  
  //MARK: - Methods
  
  //To: getData from FireBace
  func getData()
  {
    ref.child(K.RealtimeDatabase.challenge).child(self.transferedCId).observe(.value, with: {
      Datashot in
      if Datashot.value != nil
      {
        if !self.challengAttachmentModelList.isEmpty
        {
          self.challengAttachmentModelList.removeAll()
        }
        
        if let dictionary = Datashot.value as? NSDictionary{
          for (_,v) in dictionary
          {
            
            let value = v as! NSDictionary
            self.challengAttachmentModelList.append(ChallengAttachment(value: value))
            
          }
        }
        
      }
      
      self.tableViewCH.reloadData()
      
    }
    )}
  
  
  
  //MARK: - IBAction
  
  
  //To: Programmatically switch to another interface
  @IBAction func add(_ sender: Any) {
    
    if transferedCId.count > 0
    {
      let story = UIStoryboard(name: "Main",
                               bundle: nil)
      
      let courseAttatch = story.instantiateViewController(identifier: K.Storyboard.ChallengAttachmentViewController) as! ChallengAttachmentViewController
      
      courseAttatch.transferedCId = transferedCId
      courseAttatch.modalPresentationStyle = .fullScreen
      self.present(courseAttatch,
                   animated: true,
                   completion: nil)
    }
    
  }
  
}



//MARK: - extension


extension ChallengesTableViewController : UITableViewDelegate,
                                          UITableViewDataSource,
                                          MyCellDelegate {
  
  //detailseButton in cell to switch to another interface
  func didPressButton(_ tag: Int) {
    print("didFunction called".localized)
    
    let story = UIStoryboard.init(name: "Main",
                                  bundle: nil)
    
    let nextViewController = story.instantiateViewController(identifier: K.Storyboard.ChallengDetailsViewController) as? ChallengDetailsViewController
    
    nextViewController?.transferedCId = transferedCId
    nextViewController?.challingeId =  self.challengAttachmentModelList[tag].challengId
    nextViewController!.modalPresentationStyle = .fullScreen
    
    self.present(nextViewController!,
                 animated: true,
                 completion: nil)
  }
  
  
  //number Of Rows In Section
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    
    return self.challengAttachmentModelList.count
  }
  
  
  //contents the cell of Row
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard  let cell = tableView.dequeueReusableCell(withIdentifier:
                                                      K.Storyboard.ChallengeCell ,
                                                    for: indexPath) as? ChallengeCell else{
      print("error in returning Cell".localized)
      return UITableViewCell()
    }
    
    
    let titleOfCH =
      self.challengAttachmentModelList[indexPath.row].titleOfCH
    let subjectOfCH =
      self.challengAttachmentModelList[indexPath.row].subjectOfCH
    let numberOfweek =
      self.challengAttachmentModelList[indexPath.row].numberOfweek
    let numberOfCH =
      self.challengAttachmentModelList[indexPath.row].numberOfCH
    let difficultylevel =
      self.challengAttachmentModelList[indexPath.row].difficultylevel
    let model = ChallengAttachment(challengId: "",
                                   numberOfCH: numberOfCH,
                                   titleOfCH: titleOfCH,
                                   numberOfweek: numberOfweek,
                                   difficultylevel: difficultylevel,
                                   subjectOfCH: subjectOfCH,
                                   cId: transferedCId, isCompLeted: false)
    cell.initCell(model: model)
    cell.btnChallengDetails.tag = indexPath.row
    cell.myCellDelegate = self
    return cell
    
  }
  
}

























