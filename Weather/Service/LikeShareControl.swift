//
//  LikeShareControl.swift
//  Weather
//
//  Created by Olga Lidman on 17/03/2019.
//  Copyright © 2019 Home. All rights reserved.
//
import UIKit

class LikeShareControl: UIControl {
    
    @IBOutlet weak var likeImage : UIImageView!
    @IBOutlet weak var likeCountLabel : UILabel!
    @IBOutlet weak var shareImage : UIImageView!
    @IBOutlet weak var shareCountLabel : UILabel!
    
    var likeCount = 0
    var shareCount = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        likeImage.image = UIImage(named: "like")
        likeCountLabel.text = String(likeCount)
        shareImage.image = UIImage(named: "share")
        shareCountLabel.text = String(shareCount)
        
        let likeTap = UITapGestureRecognizer(target: self, action: #selector(onTapLike(recognizer:)))
        likeImage.isUserInteractionEnabled = true
        likeImage.addGestureRecognizer(likeTap)
        
        let shareTap = UITapGestureRecognizer(target: self, action: #selector(onTapShare(recognizer:)))
        shareImage.isUserInteractionEnabled = true
        shareImage.addGestureRecognizer(shareTap)
    }
    
    @objc func onTapLike(recognizer: UITapGestureRecognizer) {
        if likeImage.image == UIImage(named: "like") {
            likeCount += 1
            UIView.transition(with: self.likeCountLabel, duration: 0.5, options: .transitionFlipFromBottom, animations: {
                self.likeCountLabel.textColor = .red
                self.likeCountLabel.text = String(self.likeCount)
            }, completion: nil)
            UIView.transition(with: self.likeImage, duration: 0.5, options: .transitionFlipFromBottom, animations: {
                self.likeImage.image = UIImage(named: "like-1")
            }, completion: nil)
        } else {
            likeCount -= 1
            UIView.transition(with: self.likeCountLabel, duration: 0.5, options: .transitionFlipFromBottom, animations: {
                self.likeCountLabel.textColor = .black
                self.likeCountLabel.text = String(self.likeCount)
            }, completion: nil)
            UIView.transition(with: self.likeImage, duration: 0.5, options: .transitionFlipFromBottom, animations: {
                self.likeImage.image = UIImage(named: "like")
            }, completion: nil)
        }
    }
    
    @objc func onTapShare(recognizer: UITapGestureRecognizer) {
        if shareImage.image == UIImage(named: "share") {
            shareCount += 1
            UIView.transition(with: self.shareCountLabel, duration: 0.5, options: .transitionFlipFromBottom, animations: {
                self.shareCountLabel.textColor = .red
                self.shareCountLabel.text = String(self.shareCount)
            }, completion: nil)
            UIView.transition(with: self.shareImage, duration: 0.5, options: .transitionFlipFromBottom, animations: {
                self.shareImage.image = UIImage(named: "share-1")
            }, completion: nil)
        } else {
            shareCount -= 1
            UIView.transition(with: self.shareCountLabel, duration: 0.5, options: .transitionFlipFromBottom, animations: {
                self.shareCountLabel.textColor = .black
                self.shareCountLabel.text = String(self.shareCount)
            }, completion: nil)
            UIView.transition(with: self.shareImage, duration: 0.5, options: .transitionFlipFromBottom, animations: {
                self.shareImage.image = UIImage(named: "share")
            }, completion: nil)
        }
    }
}
