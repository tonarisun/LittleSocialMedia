//
//  User.swift
//  Weather
//
//  Created by Olga Lidman on 15/04/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import Foundation
import ObjectMapper

class User : Mappable {
    
    var userID = 0
    var userFirstName = ""
    var userLastName = ""
    var userCity = ""
    var userBDate = ""
    var avaURL = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        userID <- map["id"]
        userFirstName <- map["first_name"]
        userLastName <- map["last_name"]
        userCity <- map["city.title"]
        userBDate <- map["bdate"]
        avaURL <- map["photo_50"]
    }
}

class UserResponse : Mappable {
    
    var response = [User]()
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        response <- map["response"]
    }
}

public var currentUserID = 25776141
