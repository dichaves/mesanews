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
    
    func fetchNews(endpoint: InternalUrl.Endpoint) {
        let service = NetworkingService()
        service.fetch(endpoint: endpoint) { (allNews: AllNews) in
            self.delegate?.didGetNews(news: allNews.data)
        } failure: { (data) in
            self.delegate?.didNotGetNews(data: data)
        }
    }
}
