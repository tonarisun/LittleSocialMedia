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
        
//        Анимированное появление картинок при открытии контроллера с фото друга
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
        
        likeSharecontrolView.likeCount = 0
        likeSharecontrolView.shareCount = 0
        
//        Распознавание двойного тапа
        let likeTapTap = UITapGestureRecognizer(target: self, action: #selector(likeTapTap(recognizer:)))
        likeTapTap.numberOfTapsRequired = 2
        friendFoto.isUserInteractionEnabled = true
        friendFoto.addGestureRecognizer(likeTapTap)
    }
    
//    Лайк по двойному тапу
    @objc func likeTapTap(recognizer: UITapGestureRecognizer){
        if likeSharecontrolView.likeImage.image == UIImage(named: "dislike") {
            likeSharecontrolView.likeCount += 1
            likeSharecontrolView.like()
        } else {
            likeSharecontrolView.likeCount -= 1
            likeSharecontrolView.dislike()
        }
    }
}

