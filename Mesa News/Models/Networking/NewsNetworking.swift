//
//  NewsNetworking.swift
//  Mesa News
//
//  Created by Diana Monteiro on 15/11/20.
//

import Foundation

protocol NewsNetworkingDelegate {
    
}

struct NewsNetworking {
    var semaphore = DispatchSemaphore (value: 0)
    let authUrl = "https://mesa-news-api.herokuapp.com/v1/client/news"
    
    var delegate: NewsNetworkingDelegate?
    
    //    ?current_page=&per_page=&published_at=
    //    /highlights
    
    func fetchNews(url: String, token: String) {
        print("entrou")
        let urlString = authUrl + url
        var request = URLRequest(url: URL(string: urlString)!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token, forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            print("ué")
            print(String(data: data, encoding: .utf8)!)
            print("SINAL")
            semaphore.signal()
        }
        print("antes de dar resume")
        task.resume()
        print("saiu da task")
//        semaphore.wait()
        print("acabou a função")
    }
    
}


