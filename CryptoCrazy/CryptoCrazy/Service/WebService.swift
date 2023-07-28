//
//  WebService.swift
//  CryptoCrazy
//
//  Created by Cem Bıçakcı on 28.07.2023.
//

import Foundation

class WebService{
    
    func downloadCurrencies(url: URL, completion: @escaping([CryptoCurrency]?) -> ()){
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                completion(nil)
            }else if let data = data {
                
                let cryptolist = try? JSONDecoder().decode([CryptoCurrency].self, from: data)
                
                completion(cryptolist)
                
            }
        }.resume()
        
    }
    
}

//escaping: Fonk döndünten sonra çağırılan ve argüman yollayabildiğimiz bir fonksiyon
//İnternetten veri indireceğiz ve devamında sonucunu döndüreceğimiz için escaping kullanılır.
