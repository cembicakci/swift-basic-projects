//
//  UserSingleton.swift
//  Snapchat
//
//  Created by Cem Bıçakcı on 23.07.2023.
//

import Foundation

class UserSingleton {
    
    static let sharedUserInfo = UserSingleton()
    
    var email = ""
    var username = ""
    
    private init(){}
}
