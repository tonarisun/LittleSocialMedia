//
//  Photo.swift
//  Weather
//
//  Created by Olga Lidman on 06/05/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import Foundation
import Foundation
import ObjectMapper


class PhotoResponse : Mappable {
    
    var response = [Photo]()
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        response <- map["response.items"]
    }
}

class Photo : Mappable {
    
    var photoURL = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        photoURL <- map["sizes.2.url"]
    }
}
