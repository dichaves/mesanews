//
//  SignInUpDelegate.swift
//  Mesa News
//
//  Created by Diana Monteiro on 17/11/20.
//

import Foundation
import UIKit

protocol SignInUpDelegate {
    
    func userDidAuth()
    func userDidNotAuth(errorMessage: String)
}

extension SignInUpDelegate {
    func userDidAuth() {
        DispatchQueue.main.async {
            let feedViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
            UIApplication.shared.windows.first?.rootViewController = feedViewController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
}
