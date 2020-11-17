//
//  SignUpUser.swift
//  Mesa News
//
//  Created by Diana Monteiro on 13/11/20.
//

import Foundation

struct SignUpUser: Encodable {
    let name: String
    let email: String
    let password: String
//    let birthDate: String? // tem algum tipo de dado pra data?
}
