//
//  Friend.swift
//  Weather
//
//  Created by Olga Lidman on 16/04/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper

class Friend: Comparable, Mappable {

    var friendID = 0
    var friendFirstName = ""
    var friendLastName = ""
    var friendPicURL = ""

    required init?(map: Map) {}

    func mapping(map: Map) {
        friendID <- map["id"]
        friendFirstName <- map["first_name"]
        friendLastName <- map["last_name"]
        friendPicURL <- map["photo_50"]
    }

    static func < (lhs: Friend, rhs: Friend) -> Bool {
        return lhs.friendFirstName < rhs.friendFirstName
    }

    static func == (lhs: Friend, rhs: Friend) -> Bool {
        return lhs.friendID == rhs.friendID
    }
}

class FriendResponse : Mappable {

    var response = [Friend]()

    required init?(map: Map) {}

    func mapping(map: Map) {
        response <- map["response.items"]
    }
}
