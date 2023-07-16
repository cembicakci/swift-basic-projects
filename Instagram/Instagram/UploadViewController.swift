//
//  UploadViewController.swift
//  Instagram
//
//  Created by Cem Bıçakcı on 16.07.2023.
//

import UIKit
import Firebase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)

        
    }
    
    @objc func chooseImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    @IBAction func uploadButtonClicked(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
    
        //storage da oluşturduğumuz media klasörüne ulaşıyoruz.
        let mediaFolder = storageRef.child("media")
        
        //image i data ya çeviriyoruz.
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            
            let imageReference = mediaFolder.child("image.jpg")
            imageReference.putData(data, metadata: nil) { metadata, error in
                
                if(error != nil){
                    print("1111")
                    print(error?.localizedDescription)
                }else{
                    imageReference.downloadURL { url, error in
                        
                        if(error == nil){
                            print("2222")
                            let imageUrl = url?.absoluteString
                            print(imageUrl)
                        }
                        
                    }
                }
                
            }
            
        }
        
    }
    
}
