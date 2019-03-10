//
//  MyCommunityCell.swift
//  Weather
//
//  Created by Olga Lidman on 08/03/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class MyCommunityCell: UITableViewCell {

    @IBOutlet weak var myCommunityName: UILabel!
    @IBOutlet weak var myCommunityPic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
