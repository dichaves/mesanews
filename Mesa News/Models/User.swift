//
//  User.swift
//  Mesa News
//
//  Created by Diana Monteiro on 13/11/20.
//

import Foundation

struct User: Encodable {
    let name: String?
    let email: String
    let password: String
    let birthDate: String?
    
    init(name: String? = nil, email: String, password: String, birthDate: String? = nil) {
        self.name = name
        self.email = email
        self.password = password
        self.birthDate = birthDate
    }
}
