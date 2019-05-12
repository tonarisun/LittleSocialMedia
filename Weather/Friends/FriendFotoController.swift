//
//  FriendFotoController.swift
//  Weather
//
//  Created by Olga Lidman on 09/03/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class FriendFotoController: UICollectionViewController {
    
    var friendToShow : Friend!
    var friendPhotos = [Photo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vkRequest = VKRequest()
        vkRequest.loadPhoto(userID: "\(friendToShow!.friendID)") { photos in
            self.friendPhotos = photos
            self.collectionView.reloadData()
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friendPhotos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fotoCell", for: indexPath) as! FriendFotoCell
        cell.friendFoto.downloaded(from: friendPhotos[indexPath.row].photoURL)
        cell.likeSharecontrolView.onTapLike = {
            if cell.likeSharecontrolView.likeImage.image == UIImage(named: "like") {
                cell.likeSharecontrolView.likeCount += 1
                cell.likeSharecontrolView.like()
            } else {
                cell.likeSharecontrolView.likeCount -= 1
                cell.likeSharecontrolView.dislike()
            }
        }
        cell.likeSharecontrolView.onTapShare = {
            if cell.likeSharecontrolView.shareImage.image == UIImage(named: "share") {
               cell.likeSharecontrolView.shareCount += 1
               cell.likeSharecontrolView.share()
            } else {
                cell.likeSharecontrolView.shareCount -= 1
                cell.likeSharecontrolView.unshare()
            }
        }
        return cell
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        let hideAnimation = CABasicAnimation(keyPath: "transform.scale")
//        hideAnimation.fromValue = 1
//        hideAnimation.toValue = 0
//        hideAnimation.duration = 0.4
//        self.collectionView.layer.add(hideAnimation, forKey: nil)
//    }
}
