//
//  ViewController.swift
//  MachineLearningImageRecognition
//
//  Created by Cem Bıçakcı on 22.07.2023.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!

    var chosenImage = CIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }


    @IBAction func buttonClicked(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
        
        //aldığımız resmi ciImage sınıfı olarak oluşturuyoruz.
        if let ciImage = CIImage(image: imageView.image!) {
            chosenImage = ciImage
        }
        
        recognizeImage(image: chosenImage)
        
    }
    
    func recognizeImage(image: CIImage){
        
        //1) Request
        //2) Handler
        
        label.text = "Finding..."
        
        //MobileNetV2 => İndirdiğimiz Model
        if let model = try? VNCoreMLModel(for: MobileNetV2().model) {
            //Request
            let request = VNCoreMLRequest(model: model) { vnrequest, error in
                
                if let results = vnrequest.results as? [VNClassificationObservation] {
                    
                    if(results.count > 0){
                        
                        let topResults = results.first
                        
                        DispatchQueue.main.async {
                            //
                            let confidenceLevel = (topResults?.confidence ?? 0) * 100
                            
                            let rounded = Int(confidenceLevel * 100) / 100
                            
                            self.label.text = "\(rounded)% it is \(topResults!.identifier)"
                            
                        }
                        
                    }
                    
                }
                
            }
            
            //Handler
            let handler = VNImageRequestHandler(ciImage: image)
            DispatchQueue.global(qos: .userInteractive).async {
                do{
                    try handler.perform([request])
                    
                }catch{
                    print("error")
                    
                }
                
            }
            
        }
        
    }
}

