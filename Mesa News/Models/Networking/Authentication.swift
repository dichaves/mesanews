//
//  UserAuthentication.swift
//  Mesa News
//
//  Created by Diana Monteiro on 13/11/20.
//

import Foundation

protocol AuthenticationDelegate {
    func didAuthenticate(user: AuthenticatedUser)
    func didNotAuthenticate(data: Data)
}

struct Authentication {
    var semaphore = DispatchSemaphore (value: 0)
    let authUrl = "https://mesa-news-api.herokuapp.com/v1/client/auth/sign"
    
    var delegate: AuthenticationDelegate?
    
    func fetchToken(sign: String, postData: Data) {
        let urlString = authUrl + sign
        var request = URLRequest(url: URL(string: urlString)!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            
            if let userAuth: AuthenticatedUser = data.decode() {
                self.delegate?.didAuthenticate(user: userAuth)
            } else {
                self.delegate?.didNotAuthenticate(data: data)
            }
            
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
    }
}


