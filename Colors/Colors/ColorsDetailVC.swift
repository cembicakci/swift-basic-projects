//
//  ColorsDetailVC.swift
//  Colors
//
//  Created by Cem Bıçakcı on 11.07.2023.
//

import UIKit

class ColorsDetailVC: UIViewController{
    
    var color: UIColor?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = color ?? .blue

    }
    
}

