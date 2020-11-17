//
//  HighlightsCell.swift
//  Mesa News
//
//  Created by Diana Monteiro on 16/11/20.
//

import UIKit
import Kingfisher

class HighlightsCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var news: SingleNews! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        imageView.kf.setImage(with: URL(string: news.image_url))
        titleLabel.text = news.title
        descriptionLabel.text = news.description
    }
    
}
