//
//  CommunityCell.swift
//  Weather
//
//  Created by Olga Lidman on 08/03/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class CommunityCell: UITableViewCell {

    @IBOutlet weak var communityName: UILabel!
    @IBOutlet weak var communityPic: UIImageView!
    @IBOutlet weak var addButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
