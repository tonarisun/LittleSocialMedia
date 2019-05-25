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
    
    var likeCount = 0 {
        didSet {
            likeCountLabel.text = "\(likeCount)"
        }
    }
    
    var shareCount = 0 {
        didSet {
            shareCountLabel.text = "\(shareCount)"
        }
    }
    
    var onTapLike: (() -> Void)?
    var onTapShare: (() -> Void)?
    
    public func like() {
        UIView.transition(with: self.likeCountLabel, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.likeCountLabel.textColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
            self.likeCountLabel.text = String(self.likeCount)
        }, completion: nil)
        self.likeImage.image = UIImage(named: "like-2")
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.7
        animation.toValue = 1
        animation.stiffness = 500
        animation.mass = 2
        animation.duration = 0.5
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        self.likeImage.layer.add(animation, forKey: nil)
    }
    
    public func dislike(){
        UIView.transition(with: self.likeCountLabel, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.likeCountLabel.textColor = .black
            self.likeCountLabel.text = String(self.likeCount)
        }, completion: nil)
        self.likeImage.image = UIImage(named: "like")
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.7
        animation.toValue = 1
        animation.stiffness = 500
        animation.mass = 2
        animation.duration = 0.5
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        self.likeImage.layer.add(animation, forKey: nil)
    }
    
    public func share() {
        UIView.transition(with: self.shareCountLabel, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.shareCountLabel.textColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
            self.shareCountLabel.text = String(self.shareCount)
        }, completion: nil)
        UIView.transition(with: self.shareImage, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.shareImage.image = UIImage(named: "share-2")
        }, completion: nil)
    }
    
    public func unshare() {
        UIView.transition(with: self.shareCountLabel, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.shareCountLabel.textColor = .black
            self.shareCountLabel.text = String(self.shareCount)
        }, completion: nil)
        UIView.transition(with: self.shareImage, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.shareImage.image = UIImage(named: "share")
        }, completion: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        likeImage.image = UIImage(named: "like")
        shareImage.image = UIImage(named: "share")
        
        let likeTap = UITapGestureRecognizer(target: self, action: #selector(likeTap(recognizer:)))
        likeImage.isUserInteractionEnabled = true
        likeImage.addGestureRecognizer(likeTap)
        
        let shareTap = UITapGestureRecognizer(target: self, action: #selector(shareTap(recognizer:)))
        shareImage.isUserInteractionEnabled = true
        shareImage.addGestureRecognizer(shareTap)
    }
    
    @objc func likeTap(recognizer: UITapGestureRecognizer) {
       onTapLike!()
    }
    
    @objc func shareTap(recognizer: UITapGestureRecognizer) {
        onTapShare!()
    }
}

