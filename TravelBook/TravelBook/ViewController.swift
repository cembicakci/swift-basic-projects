//
//  ViewController.swift
//  TravelBook
//
//  Created by Cem Bıçakcı on 13.07.2023.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class ViewController: UIViewController, MKMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var commentText: UITextField!
    
    var locationManager = CLLocationManager()
    
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        
        //konuma en yakın yeri yakalamaya çalışır. kCLLocation dan başka seçeneklerde mevcut
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        //sadece uygulama kullanılırken konuma izin al
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecongizer:)))
        
        //3 saniye basınca algıla
        gestureRecognizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func chooseLocation(gestureRecongizer: UILongPressGestureRecognizer){
        
        //gestureRecognizer başladıysa
        if gestureRecongizer.state == .began {
            
            //nereye dokunuldu
            let touchedPoint = gestureRecongizer.location(in: self.mapView)
            
            //dokunulan noktayı koordinata çevir
            let touchedCoordinates = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
            
            chosenLatitude = touchedCoordinates.latitude
            chosenLongitude = touchedCoordinates.longitude
            
            //pin oluştur
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchedCoordinates
            annotation.title = nameText.text
            annotation.subtitle = commentText.text
            self.mapView.addAnnotation(annotation)
            
        }
    }
        
    //kullanıcının konumunu altıktan sonra ne yapılacak, didUpdateLocation
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //CLLocation => enlem ve boylam barındırır
        //Enlem ve boylamdan koordinatı tanımlıyoruz
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        
        //Haritada gösterebilmek için span
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        
        //region a konumu ve spani tanımlıyoruz.
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }

    
    
    @IBAction func saveButton(_ sender: Any) {
        
        //Core data ya veri kaydetmek için
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newPlace = NSEntityDescription.insertNewObject(forEntityName: "Places", into: context)
        
        newPlace.setValue(nameText.text, forKey: "title")
        newPlace.setValue(commentText.text, forKey: "subtitle")
        newPlace.setValue(chosenLatitude, forKey: "latitude")
        newPlace.setValue(chosenLongitude, forKey: "longitude")
        newPlace.setValue(UUID(), forKey: "id")
        
        do{
            try context.save()
            print("success")
        }catch{
            print("error")
        }
        
    }
    
}

