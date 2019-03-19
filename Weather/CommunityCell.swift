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
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var avatarView: Avatar!
    
    var addCommunityTapped : ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func addCommunity(_ sender: Any) {
        addCommunityTapped?(communityName.text!)
        }
    
}

