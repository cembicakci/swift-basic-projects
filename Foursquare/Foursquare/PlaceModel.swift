//
//  PlaceModel.swift
//  Foursquare
//
//  Created by Cem Bıçakcı on 20.07.2023.
//

import Foundation
import UIKit

class PlaceModel {
    
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeAtmosphere = ""
    var placeImage = UIImage()
    
    private init(){}
}
