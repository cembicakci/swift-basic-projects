//
//  AddPlaceVC.swift
//  Foursquare
//
//  Created by Cem Bıçakcı on 20.07.2023.
//

import UIKit

class AddPlaceVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var placNameText: UITextField!
    @IBOutlet weak var placeTypeText: UITextField!
    @IBOutlet weak var atmosphereText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func chooseImage (){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        
        if(placeTypeText.text != "" && placNameText.text != "" && atmosphereText.text != ""){
            
            //Singleton yapısı
            //Oluşturduğumuz PlaceModel e aktarıyoruz
            if let chosenImage = imageView.image{
                let placeModel = PlaceModel.sharedInstance
                placeModel.placeName = placNameText.text!
                placeModel.placeType = placeTypeText.text!
                placeModel.placeAtmosphere = atmosphereText.text!
                placeModel.placeImage = chosenImage
            }
            
            performSegue(withIdentifier: "toMapVC", sender: nil)
            
        }else{
            let alert = UIAlertController(title: "Error", message: "Place Name/Type/Atmosphere", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
            alert.addAction(okButton)
            self.dismiss(animated: true)
        }
        
        
        
        performSegue(withIdentifier: "toMapVC", sender: nil)
        
    }
    
}
