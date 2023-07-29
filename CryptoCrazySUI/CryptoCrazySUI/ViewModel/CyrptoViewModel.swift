//
//  CyrptoViewModel.swift
//  CryptoCrazySUI
//
//  Created by Cem Bıçakcı on 29.07.2023.
//

import Foundation

class CyrptoListViewModel: ObservableObject {
    
    @Published var cryptoList = [CyrptoViewModel]()
    
    let webService = WebService()
    
    func downloadCryptos(url: URL){
        webService.downloadCurrencies(url: url) { result in
            
            switch result {
                case.failure(let error):
                    print(error)
                
                case.success(let cryptos):
                if let cryptos = cryptos {
                    
                    DispatchQueue.main.async {
                        self.cryptoList = cryptos.map(CyrptoViewModel.init)
                    }
                    
                }
            }
        }
    }
    
}

struct CyrptoViewModel {
    
    let crypto: CyrptoCurrency
    
    var id: UUID? {
        crypto.id
    }
    
    var currency: String {
        crypto.currency
    }
    
    var price: String {
        crypto.price
    }
    
}
