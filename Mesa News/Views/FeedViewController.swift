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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        highlightsCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "HighlightsCell")
        highlightsCollectionView.delegate = self
//        newsTableView.delegate = self
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//      }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // retornar número de células
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HighlightsCell", for: indexPath)
        // Configure the cell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                          layout collectionViewLayout: UICollectionViewLayout,
                          sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = view.frame.width * 0.9
        let heightPerItem = highlightsCollectionView.frame.height

        return CGSize(width: widthPerItem, height: heightPerItem)
    }
}
