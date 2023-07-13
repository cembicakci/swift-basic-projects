//
//  ViewController.swift
//  TravelBook
//
//  Created by Cem Bıçakcı on 13.07.2023.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        
        //konuma en yakın yeri yakalamaya çalışır. kCLLocation dan başka seçeneklerde mevcut
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        //sadece uygulama kullanılırken konuma izin al

        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
        
    //kullanıcının konumunu altıktan sonra ne yapılacak, didUpdateLocation
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //CLLocation => enlem ve boylam barındırır
        //Enlem ve boylamdan koordinatı tanımlıyoruz
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        
        //Haritada gösterebilmek için span
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        
        //region a konumu ve spani tanımlıyoruz.
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }


}

