//
//  ActiveUser.swift
//  Mesa News
//
//  Created by Diana Monteiro on 17/11/20.
//

import Foundation

class ActiveUser {
    
    private init() {}
    static let shared = ActiveUser()
    
    var token: String?
}
