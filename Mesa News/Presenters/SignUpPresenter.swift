//
//  SignUpPresenter.swift
//  Mesa News
//
//  Created by Diana Monteiro on 14/11/20.
//

import Foundation

class SignUpPresenter: AuthenticationDelegate {
    
    var authentication = Authentication()
    
    init() {
        authentication.delegate = self
    }
    
    func getSignedUp(name: String, email: String, password: String) {
        let data = SignUpUser(name: name, email: email, password: password).encode()
        print("entrou no presenter")
        authentication.fetchToken(sign: "up", postData: data!)
    }
    
    func didAuthenticate(user: AuthenticatedUser) {
        print("voltou pro presenter")
        let token = user.token
        print(token)
        // usar o token para pegar as News e mandar pra FeedViewController
    }
    
    func didNotAuthenticate(data: Data) {
        let signUpErrors = decodeError(errorData: data)!
        for error in signUpErrors.errors {
            print(error.message)
        }
        // mostrar erros ao usuário
    }
    
    func decodeError(errorData: Data) -> SignUpErrors? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(SignUpErrors.self, from: errorData)
            print(decodedData)
            return decodedData
        } catch {
            print(error)
            return nil
        }
    }
}
