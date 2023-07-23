//
//  DetailsView.swift
//  FavouriteBook
//
//  Created by Cem Bıçakcı on 23.07.2023.
//

import SwiftUI

struct DetailsView: View {
    
    var chosenFavoriteElement : FavouriteElements
    
    var body: some View {
        VStack{
            Image(chosenFavoriteElement.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(chosenFavoriteElement.name)
                .font(.largeTitle)
                .padding()
            Text(chosenFavoriteElement.description)
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(chosenFavoriteElement: killbill)
    }
}
