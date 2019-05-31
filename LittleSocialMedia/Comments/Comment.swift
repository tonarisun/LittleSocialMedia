//
//  Comment.swift
//  LittleSocialMedia
//
//  Created by Olga Lidman on 31/05/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import Foundation
import RealmSwift

class Comment: Object {
    
    @objc dynamic var text = ""
    @objc dynamic var authorName = ""
    @objc dynamic var authorPicURL = ""
    @objc dynamic var time = ""
    @objc dynamic var post = ""
    
}
