//
//  FeedPresenter.swift
//  Mesa News
//
//  Created by Diana Monteiro on 17/11/20.
//

import Foundation

protocol FeedDelegate {
    func updateNews(news: [SingleNews])
}

class FeedPresenter {
    
    var newsNetworking = NewsNetworking()
    var delegate: FeedDelegate?
    
    init() {
        newsNetworking.delegate = self
    }
    
    func getNews() {
        newsNetworking.fetchNews(endpoint: .news)
    }
    
}

extension FeedPresenter: NewsNetworkingDelegate {
    
    func didGetNews(news: [SingleNews]) {
        delegate?.updateNews(news: news)
    }
    
    func didNotGetNews(data: Data) {
        print(data)
    }
}

