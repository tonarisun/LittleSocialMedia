//
//  NewPost.swift
//  Weather
//
//  Created by Olga Lidman on 15/04/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class NewPost {
    
    let author : Friend
    let currentTime : String
    let content : UIImage
    var likeCount : Int
    var shareCount : Int
    
    init(author: Friend, currentTime: String, content: UIImage, likeCount: Int, shareCount: Int){
        self.author = author
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

var post1 = NewPost(author: friend1, currentTime : getTodayString(), content : #imageLiteral(resourceName: "Bob Patrick Squidward small"), likeCount: 8, shareCount: 3)
var post2 = NewPost(author: friend5, currentTime: getTodayString(), content: #imageLiteral(resourceName: "SquidwardTentacles"), likeCount: 3, shareCount: 1)
var post3 = NewPost(author: friend2, currentTime : getTodayString(), content : #imageLiteral(resourceName: "Sandy"), likeCount: 6, shareCount: 2)
var post4 = NewPost(author: friend4, currentTime : getTodayString(), content: #imageLiteral(resourceName: "PatrickStar"), likeCount: 9, shareCount: 1)
var post5 = NewPost(author: friend6, currentTime : getTodayString(), content: #imageLiteral(resourceName: "MrKrabs"), likeCount: 12, shareCount: 0)
var post6 = NewPost(author: friend3, currentTime : getTodayString(), content: #imageLiteral(resourceName: "like-1"), likeCount: 1, shareCount: 1)
var post7 = NewPost(author: friend4, currentTime : getTodayString(), content: #imageLiteral(resourceName: "Pearl Krabs"), likeCount: 7, shareCount: 0)
var post8 = NewPost(author: friend8, currentTime : getTodayString(), content: #imageLiteral(resourceName: "plant (1)"), likeCount: 2, shareCount: 2)
var post9 = NewPost(author: friend10, currentTime : getTodayString(), content: #imageLiteral(resourceName: "Plankton"), likeCount: 9, shareCount: 1)

var newsList = [post1, post2, post3, post4, post5, post6, post7, post8,post9]
