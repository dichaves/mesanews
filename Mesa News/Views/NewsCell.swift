//
//  NewsCell.swift
//  Mesa News
//
//  Created by Diana Monteiro on 17/11/20.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var news: SingleNews! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        titleLabel.text = news.title
        descriptionLabel.text = news.description
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
