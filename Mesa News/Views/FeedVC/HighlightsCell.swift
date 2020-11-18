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
    
    var highlights: SingleNews! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        imageView.kf.setImage(with: URL(string: highlights.image_url))
        titleLabel.text = highlights.title
        descriptionLabel.text = highlights.description
    }
    
}
