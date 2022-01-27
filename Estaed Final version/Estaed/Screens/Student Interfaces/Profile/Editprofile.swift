//
//  Editprofile.swift
//  Estaed
//
//  Created by arwa balawi on 22/06/1443 AH.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class EditProfileViewController: UIViewController,
                                 UIImagePickerControllerDelegate,
                                 UINavigationControllerDelegate {
  
  // MARK: - Properties
  
  var ref : StorageReference!
  var model : User!
  var image  : UIImage!
  let id  = Auth.auth().currentUser?.uid
  
  // MARK: - IBOtlets
  
  @IBOutlet weak var firstNameText: UITextField!    
  @IBOutlet weak var lastNameText: UITextField!
  @IBOutlet weak var imageView: UIImageView!
  
  
  
  // MARK: - View controller lifecycle
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    ref = Storage.storage().reference(withPath: "gs://estaed-12178.appspot.com").child("progile").child(id!)
    if model != nil
    {
      firstNameText.text = model.firstName
      lastNameText.text = model.lasteName
      if image != nil
      {
        imageView.image = image!
      }
      
    }
    
  }
  
  //MARK: - Methods
  
  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    guard let image = info[.editedImage] as? UIImage else{return}
    imageView.image = image
    dismiss(animated: true,
            completion: nil)
  }
  
  
  
  // MARK: - IBAction
  
  
  @IBAction func didBtnTapped(_ sender: UIButton) {
    
    let picker = UIImagePickerController()
    picker.delegate = self
    picker.allowsEditing = true
    present(picker, animated: true,
            completion: nil)
  }
  
  
  
  
  @IBAction func didUpdateFireBaseTapped(_ sender: UIButton) {
    
    guard let imageData = imageView.image?.jpegData(compressionQuality: 0.4) else{return}
    let metaData = StorageMetadata()
    metaData.contentType = "image/jpg"
    
    
    self.ref.putData(imageData,
                     metadata: metaData) { StorageData, error in
      if error != nil
      {
        print("error in Uploading Image")
        
      }else
      {
        self.ref.downloadURL {
          url, Myerror in
          
          if Myerror == nil
          {
            print("getting URl")
            self.model.imageUrl = url!.absoluteString
            self.model.firstName = self.firstNameText.text!
            self.model.lasteName = self.lastNameText.text!
            Database.database().reference().child("users").child(self.id!).setValue(self.model.toDictionary()){
              referror ,DataRef in
              
              if referror != nil
              {
                print("error in updateing user data ")
                print(referror?.localizedDescription as Any)
              }else
              {
                print("user Updated Successfully")
              }
            }
          }else
          {
            print("failed to get url ")
          }
        }
      }
    }
  }
}
