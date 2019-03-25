//
//  AnimatedFotoViewController.swift
//  Weather
//
//  Created by Olga Lidman on 26/03/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class AnimatedFotoViewController: UIViewController {
    

    @IBOutlet weak var animatedFotoView2: UIImageView!
    @IBOutlet weak var animatedFotoView3: UIImageView!
    @IBOutlet weak var animatedView: UIView!
    
    
    var friendToShow : Friend!
    var i = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        friendToShow = Friend(friendName: "Mr. Krabs", friendPic:  UIImage(named: "MrKrabs")!, friendFotos: [#imageLiteral(resourceName: "MrKrabs"), #imageLiteral(resourceName: "PatrickStar"), #imageLiteral(resourceName: "Diamond-Peak-Sunset-By-Robert-Bynum-iPad-Pro-Wallpaper-2732x2732"), #imageLiteral(resourceName: "Gary"), #imageLiteral(resourceName: "like-2"), #imageLiteral(resourceName: "Pearl Krabs"), #imageLiteral(resourceName: "SquidwardTentacles"), #imageLiteral(resourceName: "Bob Patrick Squidward small")])

        animatedFotoView2.image = friendToShow.friendFotos[i]
        
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
        
        let pushTap = UITapGestureRecognizer(target: self, action: #selector(onTap(recognizer:)))
        self.animatedView.addGestureRecognizer(pushTap)
        
    }
    
    @objc func swipeLeft2(recognizer: UISwipeGestureRecognizer){
        let offset = view.bounds.width
        guard i < friendToShow.friendFotos.count-1 else { return }
        if i % 2 == 0 {
            i += 1
            animatedFotoView3.transform = CGAffineTransform(translationX: offset, y: 0)
            let animation = CABasicAnimation(keyPath: "transform.scale")
            animation.fromValue = 1
            animation.toValue = 0.5
            animation.duration = 0.6
            self.animatedFotoView2.layer.add(animation, forKey: nil)
            animatedFotoView3.image = friendToShow.friendFotos[i]
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
            animatedFotoView2.image = friendToShow.friendFotos[i]
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
            animatedFotoView3.image = friendToShow.friendFotos[i]
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
            animatedFotoView2.image = friendToShow.friendFotos[i]
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
    
    @objc func onTap(recognizer: UITapGestureRecognizer) {
        
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.9
        animation.toValue = 1
        animation.stiffness = 500
        animation.mass = 1
        animation.duration = 2
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        self.animatedView.layer.add(animation, forKey: nil)
    }
}
