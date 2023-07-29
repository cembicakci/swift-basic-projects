//
//  CyrptoCurrency.swift
//  CryptoCrazySUI
//
//  Created by Cem Bıçakcı on 29.07.2023.
//

import Foundation

struct CyrptoCurrency: Hashable, Decodable, Identifiable {
    
    let id = UUID()
    let currency: String
    let price: String
    
    private enum CodingKeys: String, CodingKey{
        case currency = "currency"
        case price = "price"
    }
    
}
