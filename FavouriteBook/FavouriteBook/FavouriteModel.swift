//
//  FavouriteModel.swift
//  FavouriteBook
//
//  Created by Cem Bıçakcı on 23.07.2023.
//

import Foundation
import SwiftUI

struct FavouriteModel: Identifiable {
    var id = UUID()
    var title: String
    var elements: [FavouriteElements]
    
}

struct FavouriteElements: Identifiable{
    var id = UUID()
    var name: String
    var imageName: String
    var description: String
}

//BANDS
let metallica = FavouriteElements(name: "Metallica", imageName: "metallica", description: "Number 1 music band")
let megadeth = FavouriteElements(name: "Megadeth", imageName: "megadeth", description: "Number 2 music band")
let ironmadien = FavouriteElements(name: "Ironmadien", imageName: "ironmaiden", description: "Number 3 music band")

let favouriteBands = FavouriteModel(title: "Favourite Bands", elements: [metallica, megadeth, ironmadien])


//MOVIES
let pulpfiction = FavouriteElements(name: "Pulp Fiction", imageName: "pulpfiction", description: "Number 1 movie")
let thedarknight = FavouriteElements(name: "The Dark Night", imageName: "thedarkknight", description: "Number 2 movie")
let killbill = FavouriteElements(name: "Kill Bill", imageName: "killbill", description: "Number 3 movie")

let favouriteMovies = FavouriteModel(title: "Favourite Movies", elements: [pulpfiction, thedarknight, killbill])


let myFavourites = [favouriteBands, favouriteMovies]


