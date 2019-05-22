//
//  AnimatedFotoViewController.swift
//  Weather
//
//  Created by Olga Lidman on 26/03/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class AnimatedFotoViewController: UIViewController {

    @IBOutlet weak var animatedFotoView2: UIImageView!
    @IBOutlet weak var animatedFotoView3: UIImageView!
    @IBOutlet weak var animatedView: UIView!
    @IBOutlet weak var likeShareControlView: LikeShareControl!
    @IBOutlet weak var noPhotoView: UIImageView!
    
    var i = 0
    var photoToShow = [Photo]()
    var likeCount = 0
    var shareCount = 0
                                                                                                        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noPhotoView.isHidden = true
        
        let vkRequest = VKRequest()
        vkRequest.loadPhoto(userID: currentUserID) { [weak self] photos in
            if photos.count != 0 {
                self?.photoToShow = photos
                let url = self?.photoToShow[(self?.i)!].photoURL
                self?.animatedFotoView2?.downloaded(from: url!)
            } else {
                self?.likeShareControlView.isHidden = true
                self?.noPhotoView.isHidden = false
                self?.noPhotoView.image = #imageLiteral(resourceName: "No photo 1")
            }
        }
        
        animatedView.isUserInteractionEnabled = true
        
        let swipe2L = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft2(recognizer:)))
        swipe2L.direction = UISwipeGestureRecognizer.Direction.left
        animatedView.addGestureRecognizer(swipe2L)
        
        let swipe2R = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight2(recognizer:)))
        swipe2R.direction = UISwipeGestureRecognizer.Direction.right
        animatedView.addGestureRecognizer(swipe2R)
        
        let showAnimationSize = CABasicAnimation(keyPath: "transform.scale")
        showAnimationSize.fromValue = 0.5
        showAnimationSize.toValue = 1
        showAnimationSize.duration = 0.4
        let showAnimationOpacity = CABasicAnimation(keyPath: "opacity")
        showAnimationOpacity.fromValue = 0
        showAnimationOpacity.toValue = 1
        showAnimationOpacity.duration = 0.7
        self.animatedView.layer.add(showAnimationOpacity, forKey: nil)
        self.animatedView.layer.add(showAnimationSize, forKey: nil)
        
        likeShareControlView.likeCountLabel.text = String(likeCount)
        likeShareControlView.shareCountLabel.text = String(shareCount)
        likeShareControlView.onTapLike = {
            if self.likeShareControlView.likeImage.image == UIImage(named: "like") {
                self.likeShareControlView.likeCount += 1
                self.likeShareControlView.like()
            } else {
                self.likeShareControlView.likeCount -= 1
                self.likeShareControlView.dislike()
            }
        }
        likeShareControlView.onTapShare = {
            if self.likeShareControlView.shareImage.image == UIImage(named: "share") {
                self.likeShareControlView.shareCount += 1
                self.likeShareControlView.share()
            } else {
                self.likeShareControlView.shareCount -= 1
                self.likeShareControlView.unshare()
            }
        }
        
    }
    
    @objc func swipeLeft2(recognizer: UISwipeGestureRecognizer){
        let offset = view.bounds.width
        guard i < photoToShow.count-1 else { return }
        if i % 2 == 0 {
            i += 1
            animatedFotoView3.transform = CGAffineTransform(translationX: offset, y: 0)
            let animation = CABasicAnimation(keyPath: "transform.scale")
            animation.fromValue = 1
            animation.toValue = 0.5
            animation.duration = 0.6
            self.animatedFotoView2.layer.add(animation, forKey: nil)
            animatedFotoView3.downloaded(from: photoToShow[i].photoURL)
            animatedView.bringSubviewToFront(animatedFotoView3)
            UIView.animate(withDuration: 0.2,
                           delay: 0.2,
                           options: .curveEaseOut,
                           animations: {
                            self.animatedFotoView3.transform = .identity
            },
                           completion: nil)
        } else {
            i += 1
            animatedFotoView2.transform = CGAffineTransform(translationX: offset, y: 0)
            let animation = CABasicAnimation(keyPath: "transform.scale")
            animation.fromValue = 1
            animation.toValue = 0.5
            animation.duration = 0.6
            self.animatedFotoView3.layer.add(animation, forKey: nil)
            animatedFotoView2.downloaded(from: photoToShow[i].photoURL)
            animatedView.bringSubviewToFront(animatedFotoView2)
            UIView.animate(withDuration: 0.2,
                           delay: 0.2,
                           options: .curveEaseOut,
                           animations: {
                            self.animatedFotoView2.transform = .identity
            },
                           completion: nil)
        }
    }
    
    @objc func swipeRight2(recognizer: UISwipeGestureRecognizer){
        let offset = view.bounds.width
        guard i > 0 else { return }
        if i % 2 == 0 {
            i -= 1
            animatedFotoView3.transform = CGAffineTransform(translationX: -offset, y: 0)
            let animation = CABasicAnimation(keyPath: "transform.scale")
            animation.fromValue = 1
            animation.toValue = 0.5
            animation.duration = 0.6
            self.animatedFotoView2.layer.add(animation, forKey: nil)
            animatedFotoView3.downloaded(from: photoToShow[i].photoURL)
            animatedView.bringSubviewToFront(animatedFotoView3)
            UIView.animate(withDuration: 0.2,
                           delay: 0.2,
                           options: .curveEaseOut,
                           animations: {
                            self.animatedFotoView3.transform = .identity
            },
                           completion: nil)
            
        } else {
            i -= 1
            animatedFotoView2.transform = CGAffineTransform(translationX: -offset, y: 0)
            let animation = CABasicAnimation(keyPath: "transform.scale")
            animation.fromValue = 1
            animation.toValue = 0.5
            animation.duration = 0.6
            self.animatedFotoView3.layer.add(animation, forKey: nil)
            animatedFotoView2.downloaded(from: photoToShow[i].photoURL)
            animatedView.bringSubviewToFront(animatedFotoView2)
            UIView.animate(withDuration: 0.2,
                           delay: 0.2,
                           options: .curveEaseOut,
                           animations: {
                            self.animatedFotoView2.transform = .identity
            },
                           completion: nil)
        }
    }
}
