//
//  ViewController.swift
//  DarkModeApp
//
//  Created by Cem Bıçakcı on 15.07.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var changeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //kullacının hangi moduna bakmaksızın, light mod olarak uygulamayı tercih et.
        //sadece bu viewController için
        overrideUserInterfaceStyle = .light
        
        //bütün app in modunu sabit yapmak için
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let userInterfaceStyle = traitCollection.userInterfaceStyle
        
        if(userInterfaceStyle == .dark){
            changeButton.tintColor = UIColor.white
        }else{
            changeButton.tintColor = UIColor.blue
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let userInterfaceStyle = traitCollection.userInterfaceStyle
        
        if(userInterfaceStyle == .dark){
            changeButton.tintColor = UIColor.white
        }else{
            changeButton.tintColor = UIColor.blue
        }
    }


}

