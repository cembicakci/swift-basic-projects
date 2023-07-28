//
//  CryptoCurrency.swift
//  CryptoCrazy
//
//  Created by Cem Bıçakcı on 28.07.2023.
//

import Foundation

struct CryptoCurrency: Decodable {
    
    //Decodable: Dışardan veri çekerken decodable olarak çekeriz.
    //Encodable: Veri yollarken
    //Codable: Decodable + Encodable
    
    let currency: String
    let price: String
    
}
