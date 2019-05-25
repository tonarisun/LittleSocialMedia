//
//  FriendNameCell.swift
//  Weather
//
//  Created by Olga Lidman on 07/03/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class FriendNameCell: UITableViewCell {
    
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var avatarView: Avatar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        friendName.text = nil
    }
}
