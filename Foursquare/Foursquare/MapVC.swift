//
//  MapVC.swift
//  Foursquare
//
//  Created by Cem Bıçakcı on 20.07.2023.
//

import UIKit
import MapKit

class MapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveButtonClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonClicked))
                
    }
    
    @objc func saveButtonClicked(){
        print("save")
    }
    
    @objc func backButtonClicked(){
        //ViewControler un bulunduğu Navigation container aksiyonunu bitirir, bir önceki navigationa geri döner.
        self.dismiss(animated: true)
        
    }


}
