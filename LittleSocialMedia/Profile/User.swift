//
//  User.swift
//  Weather
//
//  Created by Olga Lidman on 15/04/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class User : Object, Mappable {
    
    @objc dynamic var userID = 0
    @objc dynamic var userFirstName = ""
    @objc dynamic var userLastName = ""
    @objc dynamic var userCity = ""
    @objc dynamic var userBDate = ""
    @objc dynamic var avaURL = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
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