//
//  NetworkingService.swift
//  Mesa News
//
//  Created by Diana Monteiro on 18/11/20.
//

import Foundation

struct NetworkingService {
    func fetch<T:Decodable>(endpoint: InternalUrl.Endpoint,
               success: @escaping (T)->Void,
               failure: @escaping (Data)->Void ) {
        let semaphore = DispatchSemaphore (value: 0)
        let request = InternalUrl(endpoint: endpoint).createRequest()
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            
            if let object: T = data.decode() {
                success(object)
            } else {
                failure(data)
            }
            
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
    }
}
