//
//  Error.swift
//  Mesa News
//
//  Created by Diana Monteiro on 15/11/20.
//

import Foundation

struct Error: Decodable { // SignIn and News errors
    let code: String
    let message: String
}

struct SignUpErrors: Decodable {
    let errors: [SignUpError]
}

struct SignUpError: Decodable {
    let code: String
    let field: String
    let message: String
}
