//
//  SettingsVC.swift
//  Snapchat
//
//  Created by Cem Bıçakcı on 23.07.2023.
//

import UIKit
import Firebase

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

    @IBAction func logoutClicked(_ sender: Any) {
        
        do{
            
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toSignInVC", sender: nil)
            
        }catch{
            
        }
        
    }
}
