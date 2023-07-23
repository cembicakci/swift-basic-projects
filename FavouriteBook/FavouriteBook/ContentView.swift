//
//  ContentView.swift
//  FavouriteBook
//
//  Created by Cem Bıçakcı on 23.07.2023.
//

import SwiftUI

struct ContentView: View {
        
    var body: some View {
        
        NavigationView {
            
            List {
                ForEach(myFavourites) { favourite in
                    Section(header: Text(favourite.title)) {
                        ForEach(favourite.elements) { element in
                            NavigationLink(destination: DetailsView(chosenFavoriteElement: element)) {
                                Text(element.name)
                            }
                        }
                    }
                }
            }.navigationTitle("Favourite Book")
            
        }
        
      
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
