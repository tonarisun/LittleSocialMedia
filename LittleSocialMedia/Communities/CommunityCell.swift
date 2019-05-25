//
//  CommunityCell.swift
//  Weather
//
//  Created by Olga Lidman on 08/03/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class CommunityCell: UITableViewCell {
    
    var community: Community?

//    Функция конфигурации ячейки 
    func configure(community: Community) {
        self.community = community
        communityNameLabel.text = community.communityName
    }

    var addCommunityTapped : ((Community) -> Void)?

    @IBOutlet weak var communityNameLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var avatarView: Avatar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func addCommunity(_ sender: Any) {
        addCommunityTapped?(community!)
        }
}

