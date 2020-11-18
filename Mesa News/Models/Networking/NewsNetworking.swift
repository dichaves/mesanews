//
//  NewsNetworking.swift
//  Mesa News
//
//  Created by Diana Monteiro on 15/11/20.
//

import Foundation

protocol NewsNetworkingDelegate {
    func didGetNews(news: [SingleNews])
    func didNotGetNews(data: Data)
}

struct NewsNetworking {
    
    var delegate: NewsNetworkingDelegate?
    
    //    ?current_page=&per_page=&published_at=
    //    /highlights
    
    func fetchNews(url: String, token: String) {
        let semaphore = DispatchSemaphore (value: 0)
        var request = URLRequest(url: URL(string: "https://mesa-news-api.herokuapp.com/v1/client/news" + url)!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            
            if let allNews: AllNews = data.decode() {
                self.delegate?.didGetNews(news: allNews.data)
            } else {
                self.delegate?.didNotGetNews(data: data)
            }
            
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
    }
}


