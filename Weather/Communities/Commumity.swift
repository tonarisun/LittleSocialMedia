//
//  Commumity.swift
//  Weather
//
//  Created by Olga Lidman on 06/05/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class CommunityResponse : Object, Mappable {
    
    @objc dynamic var response = [Community]()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        response <- map["response.items"]
    }
}

class Community : Object, Mappable {

    @objc dynamic var communityName = ""
    @objc dynamic var pictureURL = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        communityName <- map["name"]
        pictureURL <- map["photo_50"]
    }
    
    static func == (lhs:Community, rhs:Community) -> Bool {
        return lhs.communityName == rhs.communityName
    }
}
