//
//  FriendFotoController.swift
//  Weather
//
//  Created by Olga Lidman on 09/03/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class FriendFotoController: UICollectionViewController {
    
    var friendsToShow = [Friend]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fotoCell", for: indexPath) as! FriendFotoCell
        let friend = friendsToShow[indexPath.row]
        cell.friendFoto.image = friend.friendPic
        return cell
    }
}
