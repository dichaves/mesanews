//
//  UserAuthentication.swift
//  Mesa News
//
//  Created by Diana Monteiro on 13/11/20.
//

import Foundation

protocol UserAuthDelegate {
    func didAuthorize(userAuth: ActiveUser)
}


struct Authentication {
    var semaphore = DispatchSemaphore (value: 0)
    let authUrl = "https://mesa-news-api.herokuapp.com/v1/client/auth/"
    
    var delegate: UserAuthDelegate?
    
    
    func fetchSignInInfo(user: SignInUser) {
        let parameters = "{\n\t\"email\": \"\(user.email)\",\n\t\"password\": \"\(user.password)\"\n}"
        //        let encoder = JSONEncoder()
        //        let parameters = try encoder.encode(user)
        let urlString = authUrl + "signin"
        performRequest(urlString: urlString, parameters: parameters)
    }
    
    func fetchSignUpInfo(user: SignUpUser) {
        let parameters = "{\n\t\"name\": \"\(user.name)\",\n\t\"email\": \"\(user.email)\",\n\t\"password\": \"\(user.password)\"\n}"
        let urlString = authUrl + "signup"
        performRequest(urlString: urlString, parameters: parameters)
    }
    
    func performRequest(urlString: String, parameters: String) {
        let postData = parameters.data(using: .utf8)
        var request = URLRequest(url: URL(string: urlString)!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            //            print(String(data: data, encoding: .utf8)!)
            if let userAuth = self.parseJSON(authData: data) {
                self.delegate?.didAuthorize(userAuth: userAuth)
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
            let token = decodedData.token
            return ActiveUser(token: token)
        } catch {
            print(error)
            return nil
        }
    }
}


