//
//  DetailsVC.swift
//  ArtBook
//
//  Created by Cem Bıçakcı on 12.07.2023.
//

import UIKit

class DetailsVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var artistText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //klavye dışında ekrana dokunduğumuzda klavyeyi kapatmak için 
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKey))
        view.addGestureRecognizer(gestureRecognizer)
        
    }
    
    @objc func hideKey(){
        //klavyeyi kapatacaktır
        view.endEditing(true)
    }

    @IBAction func saveButton(_ sender: Any) {
    }
    
}
