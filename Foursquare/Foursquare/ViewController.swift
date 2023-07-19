//
//  ViewController.swift
//  Foursquare
//
//  Created by Cem Bıçakcı on 19.07.2023.
//

import UIKit
import Parse

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         //Save Data to Parse
        let parseObject = PFObject(className: "Fruits")
        parseObject["name"] = "Banana"
        parseObject["calories"] = 150
        parseObject.saveInBackground { success, error in
            if(error != nil){
                print(error?.localizedDescription)
            }else{
                print("uploaded")
            }
        }
         */
        
        let query = PFQuery(className: "Fruits")
        query.findObjectsInBackground { objects, error in
            if(error != nil){
                print(error?.localizedDescription)
            }else{
                print(objects)
            }
        }
        
        
    }


}

