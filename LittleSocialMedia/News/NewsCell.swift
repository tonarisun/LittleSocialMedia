//
//  NewsCell.swift
//  Weather
//
//  Created by Olga Lidman on 17/03/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var avatarView: Avatar!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var likeShareControlView: LikeShareControl!
    @IBOutlet weak var viewsCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarView.photoView.image = nil
        authorLabel.text = nil
        timeLabel.text = nil
        contentLabel.text = nil
        contentImageView.image = nil
        likeShareControlView.likeCountLabel.text = nil
        likeShareControlView.likeCountLabel.textColor = .black
        likeShareControlView.likeImage.image = nil
        likeShareControlView.shareCountLabel.text = nil
        likeShareControlView.shareCountLabel.textColor = .black
        likeShareControlView.shareImage.image = nil
    }
}
