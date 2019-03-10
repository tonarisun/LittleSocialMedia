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
    @IBOutlet weak var friendUserpic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    class FriendUserpic: UIView {
        override class var layerClass: AnyClass {
            return CAShapeLayer.self
        }
    } 
}
