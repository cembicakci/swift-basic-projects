//
//  Router.swift
//  CryptoViper
//
//  Created by Cem Bıçakcı on 29.07.2023.
//

import Foundation

//Class, protocol
//EntryPoint -> First Screen


protocol AnyRouter{
    static func startExecution() -> AnyRouter
}

class CryptoRouter: AnyRouter{
    static func startExecution() -> AnyRouter {
        
        let router = CryptoRouter()
        return router
    }
    
}
