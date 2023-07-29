//
//  WebService.swift
//  CryptoCrazySUI
//
//  Created by Cem Bıçakcı on 29.07.2023.
//

import Foundation

class WebService {
    
    //escaping: responsun gelmesini bekleyecek, geldikten sonra result verecek. Ya CyrptoCurrency, ya da Error
    func downloadCurrencies(url: URL, completion: @escaping(Result<[CyrptoCurrency]?, DownloaderError>) -> Void){
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.badUrl))
            }
            
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            guard let currencies = try? JSONDecoder().decode([CyrptoCurrency].self, from: data) else {
                return completion(.failure(.dataParseError))
            }
            
            completion(.success(currencies))
            
        }.resume()
        
    }
    
}

enum DownloaderError: Error {
    case badUrl
    case noData
    case dataParseError
}
