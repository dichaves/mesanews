//
//  SignInPresenter.swift
//  Mesa News
//
//  Created by Diana Monteiro on 13/11/20.
//

import Foundation

protocol SignInDelegate {
    func returnError(message: String)
}

class SignInPresenter: AuthenticationDelegate {
    
    var authentication = Authentication()
    var newsNetworking = NewsNetworking()
    var delegate: SignInDelegate?

    init() {
        authentication.delegate = self
    }
    
    func getSignedIn(email: String, password: String) {
        let data = SignInUser(email: email, password: password).encode()
        authentication.fetchToken(sign: "in", postData: data!)
    }
    
    func didAuthenticate(user: ActiveUser) {
        let token = user.token
        print(token)
        newsNetworking.fetchNews(url: "?current_page=&per_page=&published_at=", token: token)
        // mandar news pro FeedViewController
        print("já saiu")
    }
    
    func didFindError(data: Data) {
        let error = decodeError(errorData: data)!
        print(error.message)
        delegate?.returnError(message: error.message)
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
