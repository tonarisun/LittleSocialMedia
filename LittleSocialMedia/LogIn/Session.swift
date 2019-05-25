//
//  Session.swift
//  Weather
//
//  Created by Olga Lidman on 24/04/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper


class Session {
    
    static let session = Session()
    
    var token = ""
    var userID = 0
    
    private init(){}
    
}

let currentSession = Session.session
