//
//  DetailsVC.swift
//  Foursquare
//
//  Created by Cem Bıçakcı on 20.07.2023.
//

import UIKit
import MapKit
import Parse

class DetailsVC: UIViewController {
    
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var detailsNameLabel: UILabel!
    @IBOutlet weak var detailsTypeLabel: UILabel!
    @IBOutlet weak var detailsAtmosphereLabel: UILabel!
    @IBOutlet weak var detailsMapView: MKMapView!
    
    var chosenPlaceId = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        //id ye göre parse dan ilgili elemanları çek
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: chosenPlaceId)
        query.findObjectsInBackground { objects, error in
            if(error != nil) {
                
            }else{
                print(objects)
            }
        }
    }
    
}
