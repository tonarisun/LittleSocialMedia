//
//  FriendFotoCell.swift
//  Weather
//
//  Created by Olga Lidman on 09/03/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class FriendFotoCell: UICollectionViewCell {
    
    @IBOutlet weak var friendFoto: UIImageView!
    @IBOutlet weak var likeSharecontrolView: LikeShareControl!
    
    override func awakeFromNib() {
        
        let pushTap = UITapGestureRecognizer(target: self, action: #selector(onTap(recognizer:)))
        self.addGestureRecognizer(pushTap)
    }
    
    @objc func onTap(recognizer: UITapGestureRecognizer) {
        
        let animation1 = CABasicAnimation(keyPath: "transform.scale")
        animation1.fromValue = 1
        animation1.toValue = 0.9
        animation1.duration = 0.5
        self.friendFoto.layer.add(animation1, forKey: nil)
        let animation2 = CASpringAnimation(keyPath: "transform.scale")
        animation2.fromValue = 0.9
        animation2.toValue = 1
        animation2.stiffness = 500
        animation2.mass = 1
        animation2.duration = 2
        animation2.isRemovedOnCompletion = false
        animation2.fillMode = CAMediaTimingFillMode.forwards
        self.friendFoto.layer.add(animation2, forKey: nil)
    }

}

