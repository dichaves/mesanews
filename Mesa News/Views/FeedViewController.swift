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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.delegate = self
        
        presenter.getNews(token: ActiveUser.shared.token)
        
        highlightsCollectionView.delegate = self
        highlightsCollectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        highlightsCollectionView.collectionViewLayout = layout
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
    }

}

extension FeedViewController: FeedDelegate {
    func updateNews(news: [SingleNews]) {
        self.news = news
    }
}

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
      }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.news!.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HighlightsCell", for: indexPath) as! HighlightsCell
        cell.news = news![indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                          layout collectionViewLayout: UICollectionViewLayout,
                          sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = view.frame.width * 0.8
        let heightPerItem = highlightsCollectionView.frame.height

        return CGSize(width: widthPerItem, height: heightPerItem)
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


}
