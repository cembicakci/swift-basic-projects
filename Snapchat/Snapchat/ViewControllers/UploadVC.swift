//
//  UploadVC.swift
//  Snapchat
//
//  Created by Cem Bıçakcı on 23.07.2023.
//

import UIKit
import Firebase

class UploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var uploadImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        uploadImageView.isUserInteractionEnabled = true
        let gestureHandler = UITapGestureRecognizer(target: self, action: #selector(choosePicture))
        uploadImageView.addGestureRecognizer(gestureHandler)
    }
    
    @objc func choosePicture(){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        uploadImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    

    @IBAction func uploadClicked(_ sender: Any) {
        
        //STORAGE
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        if let data = uploadImageView.image?.jpegData(compressionQuality: 0.5) {
            
            let uuid = UUID().uuidString
            let imageReference = mediaFolder.child("\(uuid).jpeg")
            imageReference.putData(data, metadata: nil, completion: { metadata, error in
                
                if(error != nil) {
                    self.makeAlert(title: ("Error"), message: error?.localizedDescription ?? "Error")
                }else{
                    
                    imageReference.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
                            //FIRESTORE
                                                       
                            let firestore = Firestore.firestore()
                            
                            //Kayıt işleminden önce, kullanıcı daha önce kayıt oluşturmuş mu kontrol ediyoruz.
                            //Eğer oluşturmuş ise aynı imageUrl içerisine kayıt edeceğiz.
                            
                            firestore.collection("Snaps").whereField("snapOwner", isEqualTo: UserSingleton.sharedUserInfo.username).getDocuments { snapshot, error in
                                if(error != nil) {
                                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                                }else{
                                    
                                    if(snapshot?.isEmpty == false && snapshot != nil) {
                                        
                                        //Kullanıcı daha önce paylaşım yapmış
                                        // O dökümanın id sini alıyoruz. İçerisindeki imageUrlArray ye yeni image i kaydediyoruz
                                        for document in snapshot!.documents {
                                            
                                            let documentId = document.documentID
                                            
                                            if var imageUrlArray = document.get("imageUrlArray") as? [String] {
                                                imageUrlArray.append(imageUrl!)
                                                
                                                let additionalDictionary = ["imageUrlArray": imageUrlArray] as [String: Any]
                                                
                                                //merge: Üzerinde kayıt
                                                firestore.collection("Snaps").document(documentId).setData(additionalDictionary, merge: true) { error in
                                                    if(error == nil) {
                                                        self.tabBarController?.selectedIndex = 0
                                                        self.uploadImageView.image = UIImage(named: "selectimage.png")
                                                        print("1111")
                                                    }
                                                }
                                            }
                                            
                                        }
                                    }else {
                                        //İlk defa kayıt yapacak
                                        
                                        let snapDictionary = ["imageUrlArray": [imageUrl!], "snapOwner": UserSingleton.sharedUserInfo.username, "date": FieldValue.serverTimestamp()] as [String: Any]
                                        firestore.collection("Snaps").addDocument(data: snapDictionary) { error in
                                            if error != nil {
                                                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                                            }else{
                                                self.tabBarController?.selectedIndex = 0
                                                self.uploadImageView.image = UIImage(named: "selectimage.png")
                                                print("2222")
                                            }
                                        }
                                        
                                        
                                    }
                                    
                                    
                                }
                            }
                            

                        }
                    }
                }
                    
                
            })
            
        }
        
    }
    
    func makeAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    

}
