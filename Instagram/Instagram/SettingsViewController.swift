//
//  SettingsViewController.swift
//  Instagram
//
//  Created by Cem Bıçakcı on 16.07.2023.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "toViewController", sender: nil)
    }
    
}
