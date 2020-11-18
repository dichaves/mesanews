//
//  AuthNetworking.swift
//  Mesa News
//
//  Created by Diana Monteiro on 13/11/20.
//

import Foundation

protocol AuthNetworkingDelegate {
    func didAuthenticate(user: AuthenticatedUser)
    func didNotAuthenticate(data: Data)
}

struct AuthNetworking {
    
    var delegate: AuthNetworkingDelegate?
    
    func fetchToken(endpoint: InternalUrl.Endpoint) {
        let service = NetworkingService()
        service.fetch(endpoint: endpoint) { (authUser: AuthenticatedUser) in
            self.delegate?.didAuthenticate(user: authUser)
        } failure: { (data) in
            self.delegate?.didNotAuthenticate(data: data)
        }
    }
}


