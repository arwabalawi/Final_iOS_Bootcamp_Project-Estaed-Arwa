//
//  MyFavoraitViewController.swift
//
//
//  Created by arwa balawi on 12/06/1443 AH.
//

import UIKit
import Firebase
class MyFavoraitViewController: UIViewController {
  
  
  // MARK: - Properties
  
  
  var listOfChallenges = [String]()
  var attachmentChallenges = [ChallengAttachment]()
  var ref: DatabaseReference!
  
  
  
  // MARK: - IBOtlets
  
  @IBOutlet weak var tableViewFavorait: UITableView!
  
  
  
  
  // MARK: - View controller lifecycle
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //hide back button come frome previous interface
    navigationItem.hidesBackButton = true
    
    ref = Database.database().reference()
    tableViewFavorait.dataSource = self
    tableViewFavorait.register(UINib(nibName: "myCallengesAttachmentCell",
                                     bundle: nil),
                                     forCellReuseIdentifier: "myCell")
      getData()
  }
  
    override func viewWillAppear(_ animated: Bool) {
        print("Will Apear Called")
       
    }
  
  //MARK: - Methods
  
  
  func getData() {
    ref
      .child("Favorite")
      .child(K.RealtimeDatabase.studentId)
      .observe(.value, with: { Data in
          if !self.attachmentChallenges.isEmpty
          {
            self.attachmentChallenges.removeAll()
          }
        if let dictionary = Data.value as? NSDictionary,
                                           Data.exists() {
          
          for (_ , anyValue) in dictionary {
            
            let v = anyValue as! NSDictionary
          //  self.listOfChallenges.append()
              self.addChallenges(challengId: v["challingeId"] as! String)
          }
        }
      
      })
    
  }
    func addChallenges(challengId : String)
    {
        let myRef = Database.database().reference()
        myRef.child("challenge").getData(completion: { error, Data in
        if let data = Data.value as? NSDictionary ,
                                     Data.exists(){

          for (_,v) in data  {
            let v1  = v as! NSDictionary
            for (_,value) in v1 {
              let dictionary = value as! NSDictionary
              
              let model = ChallengAttachment(value: dictionary )
             
                if model.challengId == challengId
                {
                  self.attachmentChallenges.append(model)
                    break
                }
              
            }
          }
          
          self.tableViewFavorait.reloadData()
        }
      })

    }
}



//MARK: - extension


extension MyFavoraitViewController : UITableViewDataSource,
                                     newCellDelegate {
  
    func didPressButton(_ tag: Int,_ sender : UIButton) {
        
        let challeng = self.attachmentChallenges[tag]
        if sender.currentTitle == challeng.titleOfCH
        {
            if let next = self.storyboard?
                .instantiateViewController(identifier:K.Storyboard.studentDetailsChallengeVC ) as? StudentDetailsChallengeVC
            {
              next.ChallingeId = challeng.challengId
              next.modelAttatch = challeng
              next.modalPresentationStyle = .fullScreen
              self.navigationController?.pushViewController(next,
                                                            animated: false)
            }
        }else
        {
            if tag > -1 && tag < self.attachmentChallenges.count
            {
                let ref = Database.database().reference().child("Favorite")
              
                  ref.child(K.RealtimeDatabase.studentId).child(challeng.challengId).removeValue()
                    sender.setImage(UIImage(systemName: "heart"),
                                  for: .normal)
                self.attachmentChallenges.remove(at: tag)
                self.tableViewFavorait.reloadData()
            }
            

        }
       
       
        
        
        
        
   
  }
  
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    
    return self.attachmentChallenges.count
  }
  
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard  let cell = tableView.dequeueReusableCell(withIdentifier:
                                                      "myCell",
                                                    for: indexPath) as? MyCallengesAttachmentCell else{
      print("error in returning Cell".localized)
      return UITableViewCell()
    }
    
    
      if !self.attachmentChallenges.isEmpty
      {
          let titleOfCH =
            self.attachmentChallenges[indexPath.row].titleOfCH
          let subjectOfCH =
            self.attachmentChallenges[indexPath.row].subjectOfCH
          let numberOfCH =
            self.attachmentChallenges[indexPath.row].numberOfCH
          let difficultylevel =
            self.attachmentChallenges[indexPath.row].difficultylevel
          cell.challingeId =  self.attachmentChallenges[indexPath.row].challengId
          
          
          cell.difficultyOfCh.text = difficultylevel
          cell.numberOfCh.text = numberOfCH
          cell.subjectOfCh.text = subjectOfCH
          cell.titleOfCh.setTitle(titleOfCH,
                                  for: .normal)
          cell.btnHeart.setImage(UIImage(systemName: "heart.fill"),
                                 for: .normal)
          cell.myCellDelegate = self
            cell.btnHeart.tag = indexPath.row
            cell.titleOfCh.tag  = indexPath.row
         
      }
 
      return cell
    
  }
  
  
}

