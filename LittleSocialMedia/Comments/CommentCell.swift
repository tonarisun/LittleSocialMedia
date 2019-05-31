//
//  CommentCell.swift
//  LittleSocialMedia
//
//  Created by Olga Lidman on 30/05/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var authorAvatarView: Avatar!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
