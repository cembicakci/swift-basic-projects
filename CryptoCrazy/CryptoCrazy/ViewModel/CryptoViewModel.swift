//
//  CryptoViewModel.swift
//  CryptoCrazy
//
//  Created by Cem Bıçakcı on 28.07.2023.
//

import Foundation

struct CryptoListViewModel {
    let cryptoCurrencyList: [CryptoCurrency]
    
    func numberOfRowsInSection() -> Int {
        return self.cryptoCurrencyList.count
    }
    
    func cryptoAtIndex(_index: Int) -> CryptoViewModel {
        let crypto = self.cryptoCurrencyList[_index]
        return CryptoViewModel(cryptoCurrency: crypto)
    }
}


struct CryptoViewModel {
    let cryptoCurrency: CryptoCurrency
    
    var name: String {
        return self.cryptoCurrency.currency
    }
    
    var price: String {
        return self.cryptoCurrency.price
    }
}
