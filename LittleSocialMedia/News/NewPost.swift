//
//  NewPost.swift
//  Weather
//
//  Created by Olga Lidman on 15/04/2019.
//  Copyright © 2019 Home. All rights reserved.
//


import Foundation
import UIKit
import Foundation
import ObjectMapper
import RealmSwift

class NewsPost: Mappable {
    
    var sourceID = 0
    var content = ""
    var likesCount = 0
    var sharesCount = 0
    var viewsCount = 0
    var didLike = 0
    var didShare = 0
    var time = 0.0
    var contentPicURL = ""
    var contentVideoURL = ""
    var contentDocUrl = ""
    var contentLinkURL = ""
    var author : NewsAuthor?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        sourceID <- map["source_id"]
        content <- map["text"]
        likesCount <- map["likes.count"]
        sharesCount <- map["reposts.count"]
        viewsCount <- map["views.count"]
        didLike <- map["user_likes"]
        didShare <- map["user_reposted"]
        time <- map["date"]
        contentPicURL <- map["attachments.0.photo.sizes.3.url"]
        contentVideoURL <- map["attachments.0.video.photo_800"]
        contentDocUrl <- map["attachments.0.doc.preview.photo.sizes.2.src"]
        contentLinkURL <- map["attachments.0.link.photo.sizes.0.url"]
    }
}

class NewsAuthor: Mappable {

    var id = 0
    var authorName = ""
    var authorPicURL = ""

    required init?(map: Map) { }

    func mapping(map: Map) {
        id <- map["id"]
        authorName <- map["name"]
        authorPicURL <- map["photo_50"]
    }
}

class NewsResponse: Mappable {

    var responseNews = [NewsPost]()
    var responseAuthors = [NewsAuthor]()

    required init?(map: Map) { }

    func mapping(map: Map) {
        responseNews <- map["response.items"]
        responseAuthors <- map["response.groups"]
    }
}
