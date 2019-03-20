//
//  NewsCell.swift
//  Weather
//
//  Created by Olga Lidman on 17/03/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var avanarView: Avatar!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var sendCommentButton: UIButton!
    @IBOutlet weak var likeShareControlView: LikeShareControl!
    
    var initialLikeCount = 0
    var initialShareCount = 0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialLikeCount = likeShareControlView.likeCount
        initialShareCount = likeShareControlView.shareCount
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        avanarView.image = nil
//        authorLabel.text = nil
//        timeLabel.text = nil
//        contentImageView.image = nil
//        commentTextField.text = nil
//        likeShareControlView.likeCountLabel.text = String(initialLikeCount)
//        likeShareControlView.likeCountLabel.textColor = .black
//        likeShareControlView.likeImage.image = UIImage(named: "like")
//        likeShareControlView.shareCountLabel.text = String(initialShareCount)
//        likeShareControlView.shareCountLabel.textColor = .black
//        likeShareControlView.shareImage.image = UIImage(named: "share")
//    }

}
