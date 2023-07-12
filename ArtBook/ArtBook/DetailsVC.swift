//
//  DetailsVC.swift
//  ArtBook
//
//  Created by Cem Bıçakcı on 12.07.2023.
//

import UIKit
import CoreData

class DetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var artistText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Recognizers
        
        //klavye dışında ekrana dokunduğumuzda klavyeyi kapatmak için
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKey))
        view.addGestureRecognizer(gestureRecognizer)
        
        //image recognizers
        imageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapRecognizer)
        
    }
    
    @objc func hideKey(){
        //klavyeyi kapatacaktır
        view.endEditing(true)
    }
    
    @objc func selectImage(){
        //galeriyi açmak için
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    //resim seçildikten sonra, didFinishPicking
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func saveButton(_ sender: Any) {
        
        //CoreData ya veri kaydetmek için
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //CoreData da entity tanımlarken verdiğimiz isim "Paintings"
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        
        //Attributes
        newPainting.setValue(nameText.text, forKey: "name")
        newPainting.setValue(artistText.text, forKey: "artist")
        
        if let year = Int(yearText.text!) {
            newPainting.setValue(year, forKey: "year")
        }
        
        newPainting.setValue(UUID(), forKey: "id")
        
        let data = imageView.image!.jpegData(compressionQuality: 0.5)
        
        newPainting.setValue(data, forKey: "image")
        
        do{
            try context.save()
            print("saved")
        }   catch {
            print("error")
        }
        
    }
    
}
