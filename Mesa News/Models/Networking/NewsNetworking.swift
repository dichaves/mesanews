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
            print(String(data: data, encoding: .utf8)!)
            
            if url == "/highlights" {
                if let allNews = self.decodeHighlightNews(newsData: data) {
                    self.delegate?.didGetNews(news: allNews.data)
                } else {
                    self.delegate?.didNotGetNews(data: data)
                }
            } else {
                if let allNews = self.decodeAllNews(newsData: data) {
                    self.delegate?.didGetNews(news: allNews.data)
                } else {
                    self.delegate?.didNotGetNews(data: data)
                }
            }
   
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
    }
    
    
    func decodeAllNews(newsData: Data) -> AllNews? {
        let decoder = JSONDecoder()
        do {
            let allNews = try decoder.decode(AllNews.self, from: newsData)
            print(allNews)
            return allNews
        } catch {
            print(error)
            return nil
        }
    }
    
    func decodeHighlightNews(newsData: Data) -> HighlightNews? {
        let decoder = JSONDecoder()
        do {
            let highlightNews = try decoder.decode(HighlightNews.self, from: newsData)
            print(highlightNews)
            return highlightNews
        } catch {
            print(error)
            return nil
        }
    }
}


