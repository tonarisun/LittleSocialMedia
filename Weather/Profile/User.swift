//
//  User.swift
//  Weather
//
//  Created by Olga Lidman on 15/04/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class User {
    let userName : String
    var userPic : UIImage
    var userAge : Int
    var userCity : String
    var userFotos = [UIImage]()
    
    init(userName: String, userPic: UIImage, userAge: Int, userCity: String, userFotos: [UIImage]) {
        self.userName = userName
        self.userPic = userPic
        self.userAge = userAge
        self.userCity = userCity
        self.userFotos = userFotos
    }
}

var user1 = User(userName: "Olga Lidman", userPic: #imageLiteral(resourceName: "my face"), userAge: 32, userCity: "Novosibirsk", userFotos: [UIImage(named: "like-1")!, UIImage(named: "plant")!, UIImage(named: "share")!, UIImage(named: "mail")!, UIImage(named: "news")!])
