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
        var currentTime : String
        var content : UIImage
    
    init(author: Friend, currentTime: String, content: UIImage){
        self.author = author
        self.currentTime = currentTime
        self.content = content
    }
    
}
