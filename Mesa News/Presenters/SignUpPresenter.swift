//
//  SignUpPresenter.swift
//  Mesa News
//
//  Created by Diana Monteiro on 14/11/20.
//

import Foundation

class SignUpPresenter: AuthenticationDelegate {
    
    var authentication = Authentication()
    var delegate: SignInUpDelegate?
    
    init() {
        authentication.delegate = self
    }
    
    func getSignedUp(name: String, email: String, password: String, birthDate: String) {
        let data = SignUpUser(name: name, email: email, password: password, birthDate: birthDate).encode()
        authentication.fetchToken(sign: "up", postData: data!)
    }
    
    func didAuthenticate(user: AuthenticatedUser) {
        ActiveUser.shared.token = user.token
        delegate?.userDidAuth()
    }
    
    func didNotAuthenticate(data: Data) {
        if let signUpErrors: SignUpErrors = data.decode() {
            let errorMessages = signUpErrors.errors.map { $0.message }
            let message = errorMessages.joined(separator: "\n")
            
            delegate?.userDidNotAuth(errorMessage: message)
        }
    }
}
