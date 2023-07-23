//
//  ContentView.swift
//  FavouriteBook
//
//  Created by Cem Bıçakcı on 23.07.2023.
//

import SwiftUI

struct ContentView: View {
        
    var body: some View {
        List {
            ForEach(myFavourites) { favourite in
                Section(header: Text(favourite.title)) {
                    ForEach(favourite.elements) { element in
                        Text(element.name)
                    }
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
