//
//  SignInPresenter.swift
//  Mesa News
//
//  Created by Diana Monteiro on 13/11/20.
//

import Foundation

class SignInPresenter {
    
    var authentication = Authentication()
    var delegate: SignInUpDelegate?

    init() {
        authentication.delegate = self
    }
    
    func getSignedIn(email: String, password: String) {
        let data = SignInUser(email: email, password: password).encode()
        authentication.fetchToken(sign: "in", postData: data!)
    }
}

extension SignInPresenter: AuthenticationDelegate {
    
    func didAuthenticate(user: AuthenticatedUser) {
        ActiveUser.shared.token = user.token
        delegate?.userDidAuth()
    }
    
    func didNotAuthenticate(data: Data) {
        let error = decodeError(errorData: data)!
        delegate?.userDidNotAuth(errorMessage: error.message)
    }
    
    func decodeError(errorData: Data) -> Error? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(Error.self, from: errorData)
            print(decodedData)
            return decodedData
        } catch {
            print(error)
            return nil
        }
    }
}
