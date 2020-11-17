//
//  UserAuthentication.swift
//  Mesa News
//
//  Created by Diana Monteiro on 13/11/20.
//

import Foundation

protocol AuthenticationDelegate {
    func didAuthenticate(user: ActiveUser)
    func didFindError(data: Data)
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
                print("deu ruim")
                print(String(describing: error))
                return
            }
            print("foi quase")
            print(String(data: data, encoding: .utf8)!)
            if let userAuth = self.parseJSON(authData: data) {
                print("deu bom")
                self.delegate?.didAuthenticate(user: userAuth)
            } else {
                self.delegate?.didFindError(data: data)
            }
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
    }
    
    
    func parseJSON(authData: Data) -> ActiveUser? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ActiveUser.self, from: authData)
            print(decodedData)
            print("try")
            let token = decodedData.token
            return ActiveUser(token: token)
        } catch {
            print(error)
            print("é, errou")
            return nil
        }
    }
}


