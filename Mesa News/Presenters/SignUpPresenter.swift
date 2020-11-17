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
    
    func getSignedUp(name: String, email: String, password: String) {
        let data = SignUpUser(name: name, email: email, password: password).encode()
        authentication.fetchToken(sign: "up", postData: data!)
    }
    
    func didAuthenticate(user: AuthenticatedUser) {
        ActiveUser.shared.token = user.token
        delegate?.userDidAuth()
    }
    
    func didNotAuthenticate(data: Data) {
        let signUpErrors = decodeError(errorData: data)!
        var message = ""
        for error in signUpErrors.errors {
            message += "\(error.message)\n"
        }
        delegate?.userDidNotAuth(errorMessage: message)
    }
    
    func decodeError(errorData: Data) -> SignUpErrors? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(SignUpErrors.self, from: errorData)
            return decodedData
        } catch {
            print(error)
            return nil
        }
    }
}
