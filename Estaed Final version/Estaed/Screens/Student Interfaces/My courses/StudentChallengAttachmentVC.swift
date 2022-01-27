//
//  StudentChallengeViewController.swift
//  Estaed
//
//  Created by arwa balawi on 01/06/1443 AH.
//

import UIKit
import Firebase

class StudentChallengAttachmentVC: UIViewController,
                                   UITextFieldDelegate,
                                   UIPickerViewDelegate,
                                   UIPickerViewDataSource {
  
  // MARK: - Properties
  
  var model = ChallengAttachment()
  var diffList = ["All","Easy","Medium","Hard"]
  let toolBar = UIToolbar()
  
  var ChallengAttachmentModelList = [ChallengAttachment]()
  var ref: DatabaseReference!
  var refreshControl = UIRefreshControl()
  var transferedCId = ""
  
  let piker = UIPickerView()
  var  easyQuestion = [ChallengAttachment]()
  var  meduimQuestion = [ChallengAttachment]()
  var  hardQuestion = [ChallengAttachment]()
  var diff = false
  var diffText = ""
  
  
  // MARK: - IBOtlets

  
  @IBOutlet weak var progress: UIProgressView!
  @IBOutlet weak var difficutlyTextFilde: UITextField!
  @IBOutlet weak var tableViewStudentCH: UITableView!
  
  
  
  // MARK: - View controller lifecycle
 
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    piker.delegate = self
    piker.dataSource = self
    difficutlyTextFilde.delegate = self
    difficutlyTextFilde.inputView = piker
    difficutlyTextFilde.inputAccessoryView = toolBar
    toolBar.sizeToFit()
    let btnDone = UIBarButtonItem(title:"Done".localized,
                                  style: .plain ,
                                  target: self ,
                                  action: #selector(closePicker))
    
    toolBar.setItems([btnDone],
                     animated: true)
    
    tableViewStudentCH.register(UINib(nibName: "myCallengesAttachmentCell",
                                      bundle: nil),
                                forCellReuseIdentifier: "myCell")
    tableViewStudentCH.delegate = self
    tableViewStudentCH.dataSource = self
    ref = Database.database().reference()
    getData()
    print("View Loaded")
  }
  
    override func viewWillAppear(_ animated: Bool) {
     
      print("View Will Apear")
    }
  
  override func touchesBegan(_ touches: Set<UITouch>,
                             with event: UIEvent?) {
    view.endEditing(true)
  }
  
  
  
  
  //MARK: - Methods

  
  
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  
  func pickerView(_ pickerView: UIPickerView,
                  numberOfRowsInComponent component: Int) -> Int {
    return diffList.count
  }
  
  
  @objc func closePicker() {
    view.endEditing(true)
    
  }
  
  
  func pickerView(_ pickerView: UIPickerView,
                  didSelectRow row: Int,
                  inComponent component: Int) {
    
    self.difficutlyTextFilde.text = self.diffList[row]
  }
  
  
  func pickerView(_ pickerView: UIPickerView,
                  titleForRow row: Int,
                  forComponent component: Int) -> String?{
    
    return self.diffList[row]
  }
  
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    
    difficutlyTextFilde.resignFirstResponder()
    print("finshed Editing".localized)
    diff = true
    diffText = textField.text!
    self.tableViewStudentCH.reloadData()
    
  }
  
  
  func getData()
  {
    print("get Challenge Data start")
    print("chall : \(K.RealtimeDatabase.challenge)")
    print("courseId : \(transferedCId)")
    
    if !self.ChallengAttachmentModelList.isEmpty
    {
      self.ChallengAttachmentModelList.removeAll()
    }
    if !self.hardQuestion.isEmpty
    {
      self.hardQuestion.removeAll()
    }
    if !self.meduimQuestion.isEmpty
    {
      self.meduimQuestion.removeAll()
    }
    if !self.easyQuestion.isEmpty
    {
      self.easyQuestion.removeAll()
    }
    
    ref.child(K.RealtimeDatabase.challenge).child(self.transferedCId).observe(.value, with: {  Data in
      
      if let dictionary = Data.value as? NSDictionary ,Data.exists(){
        for (_,v0) in dictionary {
          
          
          let value = v0 as! NSDictionary
          let myModel = ChallengAttachment(value: value)
          if myModel.courseId == self.transferedCId
          {
            self.ChallengAttachmentModelList.append(myModel)
            if myModel.difficultylevel == "Hard"
            {
              self.hardQuestion.append(myModel)
            }else if myModel.difficultylevel == "Medium" {
              self.meduimQuestion.append(myModel)
            }else if myModel.difficultylevel == "Easy"{
              self.easyQuestion.append(myModel)
            }
          }
        }
      }
      
      
      if !self.ChallengAttachmentModelList.isEmpty
      {
        var CompletedCount = 0
        for index in self.ChallengAttachmentModelList
        {
          if index.isCompLeted
          {
            CompletedCount += 1
          }
        }
        let progress = Float(CompletedCount / self.ChallengAttachmentModelList.count)
        print("progress : \(progress)")
        self.progress.progress = progress
        
      }
      self.tableViewStudentCH.reloadData()
      
    }
    )}
}




//MARK: - extension


extension StudentChallengAttachmentVC : UITableViewDelegate,
                                        UITableViewDataSource,
                                        newCellDelegate {
  
    func didPressButton(_ tag: Int, _ sender : UIButton) {
        
        if diff
        {
          if diffText == "Easy"
          {
              self.model =  self.easyQuestion[tag]
          }else if diffText == "Medium"
          {
              self.model =  self.meduimQuestion[tag]
          }else if diffText == "Hard"
          {
            
              self.model =  self.hardQuestion[tag]
          }else
          {
              self.model =  self.ChallengAttachmentModelList[tag]
          }
          
        }else
        {
            self.model =  self.ChallengAttachmentModelList[tag]
        }
        if sender.currentTitle == model.titleOfCH
        {
            if let next = self.storyboard?
                .instantiateViewController(identifier:K.Storyboard.studentDetailsChallengeVC ) as? StudentDetailsChallengeVC
            {
                next.ChallingeId = self.model.challengId
                next.modelAttatch = self.model
              next.modalPresentationStyle = .fullScreen
              self.navigationController?.pushViewController(next,
                                                            animated: false)
            }
        }else
        {
            Database.database().reference().child("Favorite").child(K.RealtimeDatabase.studentId).child(model.challengId).setValue([
            "challingeId" : model.challengId ,
            "StudentId" : K.RealtimeDatabase.studentId ,
            "isCompLeted" : false
          ]){ error ,
              Data in
            
            if error == nil
            {
                sender.setImage(UIImage(systemName: "heart.fill"),
                              for: .normal)
 
            }
            
          }
        }
 
    
  }
  
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    if diff
    {
      if diffText == "Easy"
      {
        return self.easyQuestion.count
      }else if diffText == "Medium"
      {
        return self.meduimQuestion.count
      }else if diffText == "Hard"
      {
        
        return self.hardQuestion.count
      }else
      {
        return self.ChallengAttachmentModelList.count
      }
      
    }else
    {
      return self.ChallengAttachmentModelList.count
    }
    
  }
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    // let cell = tableView.dequeue() as! TableChallengeCell
    guard  let cell = tableView.dequeueReusableCell(withIdentifier:"myCell",
                                                    for: indexPath) as? MyCallengesAttachmentCell else{
      print("error in returning Cell".localized)
      return UITableViewCell()
    }
    
    print("diff = \(diff)   diffText : \(diffText)")
    if diff
    {
      if diffText == "Easy"
      {
        model = self.easyQuestion[indexPath.row]
      }else if diffText == "Medium"
      {
        model = self.meduimQuestion[indexPath.row]
      }else if diffText == "Hard"
      {
        
        model = self.hardQuestion[indexPath.row]
      }else if diffText == "All"
      {
        if !self.ChallengAttachmentModelList.isEmpty
        {
          model = self.ChallengAttachmentModelList[indexPath.row]
          
        }
      
      }
      
    }else
    {
      if !self.ChallengAttachmentModelList.isEmpty
      {
        model = self.ChallengAttachmentModelList[indexPath.row]
        
      }
    }
    
    
    ref.child("Favorite").child(K.RealtimeDatabase.studentId).child(model.challengId).observe(.value, with: { Data in
      if Data.exists(){
        
        cell.btnHeart.setImage(UIImage(systemName: "heart.fill"),
                               for: .normal)
      }else
      {
        cell.btnHeart.setImage(UIImage(systemName: "heart"),
                               for: .normal)
      }
    })
    cell.accessoryType = model.isCompLeted ? .checkmark : .none
    cell.challingeId =  model.challengId
    cell.numOfWeekLabel.text = model.numberOfweek
    cell.difficultyOfCh.text = model.difficultylevel
    cell.numberOfCh.text =  model.numberOfCH
    cell.subjectOfCh.text =  model.subjectOfCH
    cell.titleOfCh.setTitle(model.titleOfCH,
                            for: .normal)
      cell.titleOfCh.tag = indexPath.row
      cell.btnHeart.tag = indexPath.row
    cell.myCellDelegate = self
    return cell
    
  }
  
}

