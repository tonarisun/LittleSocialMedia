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
        
        let showAnimationSize = CABasicAnimation(keyPath: "transform.scale")
        showAnimationSize.fromValue = 0.5
        showAnimationSize.toValue = 1
        showAnimationSize.duration = 0.4
        let showAnimationOpacity = CABasicAnimation(keyPath: "opacity")
        showAnimationOpacity.fromValue = 0
        showAnimationOpacity.toValue = 1
        showAnimationOpacity.duration = 0.7
        self.layer.add(showAnimationOpacity, forKey: nil)
        self.layer.add(showAnimationSize, forKey: nil)
        
        let pushTap = UILongPressGestureRecognizer(target: self, action: #selector(pushLongPress(recognizer:)))
        self.addGestureRecognizer(pushTap)
        
        let likeTapTap = UITapGestureRecognizer(target: self, action: #selector(likeTapTap(recognizer:)))
        likeTapTap.numberOfTapsRequired = 2
        friendFoto.isUserInteractionEnabled = true
        friendFoto.addGestureRecognizer(likeTapTap)
    }
    
    @objc func pushLongPress(recognizer: UILongPressGestureRecognizer) {
        
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.9
        animation.toValue = 1
        animation.stiffness = 500
        animation.mass = 1
        animation.duration = 2
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        self.friendFoto.layer.add(animation, forKey: nil)
    }
    
    @objc func likeTapTap(recognizer: UITapGestureRecognizer){
        likeSharecontrolView.onTapLike(recognizer: recognizer)
    }
}

