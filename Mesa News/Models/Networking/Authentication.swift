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
    
    var delegate: AuthenticationDelegate?
    
    func fetchToken(endpoint: InternalUrl.Endpoint) {
        let request = InternalUrl(endpoint: endpoint).createRequest()
        
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


