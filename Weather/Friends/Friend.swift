//
//  Friend.swift
//  Weather
//
//  Created by Olga Lidman on 16/04/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class Friend: Comparable {
    
    let friendName : String
    var friendPic : UIImage
    var friendFotos = [UIImage]()
    
    init(friendName: String, friendPic: UIImage, friendFotos: [UIImage]){
        self.friendName = friendName
        self.friendPic = friendPic
        self.friendFotos = friendFotos
    }
    
    static func < (lhs: Friend, rhs: Friend) -> Bool {
        return lhs.friendName < rhs.friendName
    }
    
    static func == (lhs: Friend, rhs: Friend) -> Bool {
        return lhs.friendName == rhs.friendName
    }
}

var friend1 = Friend(friendName: "SpongeBob SquarePants", friendPic:  UIImage(named: "SpongeBob")!, friendFotos: [#imageLiteral(resourceName: "SpongeBob"), #imageLiteral(resourceName: "cat"), #imageLiteral(resourceName: "cactus"), #imageLiteral(resourceName: "flower-pot")])
var friend2 = Friend(friendName: "Patrick Star", friendPic:  UIImage(named: "PatrickStar")!, friendFotos: [#imageLiteral(resourceName: "PatrickStar"), #imageLiteral(resourceName: "cactus"), #imageLiteral(resourceName: "like")])
var friend3 = Friend(friendName: "Squidward Tentacles", friendPic:  UIImage(named: "SquidwardTentacles")!, friendFotos: [#imageLiteral(resourceName: "SquidwardTentacles"), #imageLiteral(resourceName: "cat"), #imageLiteral(resourceName: "cactus"), #imageLiteral(resourceName: "flower-pot")])
var friend4 = Friend(friendName: "Mr. Krabs", friendPic:  UIImage(named: "MrKrabs")!, friendFotos: [#imageLiteral(resourceName: "MrKrabs"), #imageLiteral(resourceName: "cat"), #imageLiteral(resourceName: "cactus"), #imageLiteral(resourceName: "flower-pot")] )
var friend5 = Friend(friendName: "Sandy Cheeks", friendPic:  UIImage(named: "Sandy")!, friendFotos: [#imageLiteral(resourceName: "Sandy"), #imageLiteral(resourceName: "cat"), #imageLiteral(resourceName: "cactus"), #imageLiteral(resourceName: "like-2"), #imageLiteral(resourceName: "bud")])
var friend6 = Friend(friendName: "Plankton", friendPic:  UIImage(named: "Plankton")!, friendFotos: [#imageLiteral(resourceName: "Plankton"), #imageLiteral(resourceName: "cat"), #imageLiteral(resourceName: "cactus"), #imageLiteral(resourceName: "flower-pot")])
var friend7 = Friend(friendName: "Karen", friendPic:  UIImage(named: "Karen")!, friendFotos: [#imageLiteral(resourceName: "Karen"), #imageLiteral(resourceName: "cat"), #imageLiteral(resourceName: "cactus"), #imageLiteral(resourceName: "Plankton")])
var friend8 = Friend(friendName: "Mrs. Puff", friendPic:  UIImage(named: "Puff")!, friendFotos: [#imageLiteral(resourceName: "Puff"), #imageLiteral(resourceName: "cat"), #imageLiteral(resourceName: "cactus"), #imageLiteral(resourceName: "flower-pot")])
var friend9 = Friend(friendName: "Pearl Krabs", friendPic:  UIImage(named: "Pearl Krabs")!, friendFotos: [#imageLiteral(resourceName: "Pearl Krabs"), #imageLiteral(resourceName: "cat"), #imageLiteral(resourceName: "circle")])
var friend10 = Friend(friendName: "Gary the Snail", friendPic:  UIImage(named: "Gary")!, friendFotos: [#imageLiteral(resourceName: "Gary"), #imageLiteral(resourceName: "cat"), #imageLiteral(resourceName: "plant")])

var friendList = [friend1, friend2, friend3, friend4, friend5, friend6, friend7, friend8, friend9, friend10]
