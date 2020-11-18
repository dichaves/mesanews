//
//  FeedPresenter.swift
//  Mesa News
//
//  Created by Diana Monteiro on 17/11/20.
//

import Foundation

protocol FeedDelegate {
    func updateNews(news: [SingleNews])
    func updateHighlights(highlights: [SingleNews])
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
    
    func getHighlights() {
        newsNetworking.fetchNews(endpoint: .highlights)
    }
    
}

extension FeedPresenter: NewsNetworkingDelegate {
    
    func didGetNews(news: [SingleNews]) {
        let sortedNews = sortNewsByDate(news: news)
        delegate?.updateNews(news: sortedNews)
    }
    
    func sortNewsByDate(news: [SingleNews]) -> [SingleNews] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-dd-MM'T'HH:mm:ss.SSS'Z'"
        
        var mutableNews = news
        for index in 0..<mutableNews.count {
            mutableNews[index].date = formatter.date(from: mutableNews[index].published_at)
        }
        
        let sortedNews = mutableNews.sorted { $0.date!.compare($1.date!) == .orderedDescending }
        
        return sortedNews
    }
    
    func didGetHighlights(highlights: [SingleNews]) {
        delegate?.updateHighlights(highlights: highlights)
    }
    
    func didNotGetNews(data: Data) {
        print(data)
    }
}

