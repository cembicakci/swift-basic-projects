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
    
    var chosenPainting = ""
    var chosenPaintingId : UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(chosenPainting != ""){
            //CoreData
            
            //Tableview dan gönderdiğimiz id nin detaylarını coredata dan çekme
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            let idString = chosenPaintingId?.uuidString
            
            //NSPredicate: Aramada oluşturacağımız sınırlar içerisinde yapılan mantıksan tanınlamalar. Koşulu getirecek, bütün kayıtlı data ları değil.
            //id si sağdaki id ye eşit olanı getir.
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString!)
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                
                if (results.count > 0) {
                    for result in results as! [NSManagedObject] {
                        if let name = result.value(forKey: "name") as? String {
                            nameText.text = name
                        }
                        
                        if let artist = result.value(forKey: "artist") as? String {
                            artistText.text = artist
                        }
                        
                        if let year = result.value(forKey: "year") as? Int {
                            yearText.text = String(year)
                        }
                        
                        if let imageData = result.value(forKey: "image") as? Data {
                            let image = UIImage(data: imageData)
                            imageView.image = image
                        }
                    }
                }
            }catch{
                print("error")
            }
            
            
        } else{
            nameText.text = ""
            artistText.text = ""
            yearText.text = ""
        }
        
        
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
        
        //Notification Center => Diğer view controllera mesaj yollamak için
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        
        //navigation.goBack()
        self.navigationController?.popViewController(animated: true)
    }
    
}
