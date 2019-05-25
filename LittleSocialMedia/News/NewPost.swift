//
//  NewPost.swift
//  Weather
//
//  Created by Olga Lidman on 15/04/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class NewPost {
    
    let authorName : String
    let authorPic : UIImage
    let currentTime : String
    let content : UIImage
    var likeCount : Int
    var shareCount : Int
    
    init(authorName: String, authorPic: UIImage, currentTime: String, content: UIImage, likeCount: Int, shareCount: Int){
        self.authorName = authorName
        self.authorPic = authorPic
        self.currentTime = currentTime
        self.content = content
        self.likeCount = likeCount
        self.shareCount = shareCount
    }
}

func getTodayString() -> String {
    
    let date = Date()
    let calender = Calendar.current
    let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
    let year = components.year
    let month = components.month
    let day = components.day
    let hour = components.hour
    let minute = components.minute
    let second = components.second
    
    let today_string = String(year!) + "-" + String(month!) + "-" + String(day!) + " " + String(hour!)  + ":" + String(minute!) + ":" +  String(second!)
    
    return today_string
}

var post1 = NewPost(authorName: "Squidward Tentacles", authorPic: #imageLiteral(resourceName: "SquidwardTentacles"), currentTime : getTodayString(), content : #imageLiteral(resourceName: "SquidwardTentacles"), likeCount: 8, shareCount: 3)
var post2 = NewPost(authorName: "Karen", authorPic: #imageLiteral(resourceName: "Karen"), currentTime: getTodayString(), content: #imageLiteral(resourceName: "Plankton"), likeCount: 3, shareCount: 1)
var post3 = NewPost(authorName: "Patrick Star", authorPic: #imageLiteral(resourceName: "PatrickStar"), currentTime : getTodayString(), content : #imageLiteral(resourceName: "Bob Patrick Squidward small"), likeCount: 6, shareCount: 2)
var post4 = NewPost(authorName: "Missis Puff", authorPic: #imageLiteral(resourceName: "Puff"), currentTime : getTodayString(), content: #imageLiteral(resourceName: "bud"), likeCount: 9, shareCount: 1)
var post5 = NewPost(authorName: "Mister Krubs", authorPic: #imageLiteral(resourceName: "MrKrabs"), currentTime : getTodayString(), content: #imageLiteral(resourceName: "Pearl Krabs"), likeCount: 12, shareCount: 0)
var post6 = NewPost(authorName: "Cosmo Cat", authorPic: #imageLiteral(resourceName: "cat"), currentTime : getTodayString(), content: #imageLiteral(resourceName: "picture"), likeCount: 1, shareCount: 1)
var post7 = NewPost(authorName: "Little Plant", authorPic: #imageLiteral(resourceName: "flower-pot"), currentTime : getTodayString(), content: #imageLiteral(resourceName: "plant"), likeCount: 7, shareCount: 0)
var post8 = NewPost(authorName: "Green Man", authorPic: #imageLiteral(resourceName: "user"), currentTime : getTodayString(), content: #imageLiteral(resourceName: "users-1"), likeCount: 2, shareCount: 2)
var post9 = NewPost(authorName: "Olga Lidman", authorPic: #imageLiteral(resourceName: "my face"), currentTime : getTodayString(), content: #imageLiteral(resourceName: "Diamond-Peak-Sunset-By-Robert-Bynum-iPad-Pro-Wallpaper-2732x2732"), likeCount: 9, shareCount: 1)

var newsList = [post1, post2, post3, post4, post5, post6, post7, post8,post9]
