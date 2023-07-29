//
//  ContentView.swift
//  AsyncImage
//
//  Created by Cem Bıçakcı on 29.07.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView {
            
            VStack {
                AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1690309575935-3a70fa5d797b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2786&q=80")) { image in
                    image.resizable().frame(width: 300, height: 300, alignment: .center)
                } placeholder: {
                    ProgressView()
                }

               
                List(superHeroArray){ superhero in
                    Text(superhero.name)
                        .font(.title3)
                        .foregroundColor(.blue)
                }.navigationTitle(Text("Superhero"))
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
