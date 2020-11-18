//
//  FeedViewController.swift
//  Mesa News
//
//  Created by Diana Monteiro on 15/11/20.
//

import UIKit

class FeedViewController: UIViewController {
    
    @IBOutlet weak var highlightsCollectionView: UICollectionView!
    @IBOutlet weak var newsTableView: UITableView!
    
    var presenter = FeedPresenter()
    var news: [SingleNews]?
    var highlights: [SingleNews]?
    var urlStr: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.delegate = self
        
        presenter.getNews()
        presenter.getHighlights()
        
        highlightsCollectionView.delegate = self
        highlightsCollectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        highlightsCollectionView.collectionViewLayout = layout
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        newsTableView.rowHeight = UITableView.automaticDimension
        newsTableView.estimatedRowHeight = 600
    }
    
}

extension FeedViewController: FeedDelegate {
    func updateNews(news: [SingleNews]) {
        self.news = news
    }
    
    func updateHighlights(highlights: [SingleNews]) {
        self.highlights = highlights
    }
}

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.highlights!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HighlightsCell", for: indexPath) as! HighlightsCell
        cell.highlights = highlights![indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = view.frame.width * 0.8
        let heightPerItem = highlightsCollectionView.frame.height
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        prepareSegueFor(index: indexPath.item)
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.news!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        cell.news = news![indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        prepareSegueFor(index: indexPath.item)
    }
    
    func prepareSegueFor(index: Int) {
        urlStr = news![index].url
        DispatchQueue.main.async { self.performSegue(withIdentifier: "FeedToNewsWebView", sender: self) }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let newsWebVC = segue.destination as? NewsWebViewController else {
            return
        }
        newsWebVC.urlStr = urlStr
    }
}
