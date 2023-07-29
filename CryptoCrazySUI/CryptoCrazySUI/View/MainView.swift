//
//  ContentView.swift
//  CryptoCrazySUI
//
//  Created by Cem Bıçakcı on 29.07.2023.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var cryptoListViewModel : CyrptoListViewModel
    
    init(){
        self.cryptoListViewModel = CyrptoListViewModel()
    }
    
    var body: some View {
        
        NavigationView {
            
            List(cryptoListViewModel.cryptoList, id:\.id){ crypto in
                VStack {
                    Text(crypto.currency)
                        .font(.title3)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(crypto.price)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }.navigationTitle("Crypto Crazy")
        }.task {
            await cryptoListViewModel.downloadCryptosAsync(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
            
        }
        /*
        .onAppear {
            /*
            cryptoListViewModel.downloadCryptos(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
             */
        }
         
         */
    }
    
    //async await kullanacaksak navigationView de task ile fonksiyonu yazmamız lazım.
    //Çünkü onAppear async await olarak çalışmıyor.
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            MainView()
        }
    }
    
}
    

