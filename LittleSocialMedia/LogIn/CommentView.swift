//
//  CommentView.swift
//  LittleSocialMedia
//
//  Created by Olga Lidman on 30/05/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import Foundation
import UIKit

class CommentView : UIView {
    
    @IBOutlet weak var authorPicView: UIImageView!
    @IBOutlet weak var currentTimeView: UILabel!
    @IBOutlet weak var authorNameView: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        authorPicView.clipsToBounds = true
        authorPicView.layer.cornerRadius = authorPicView.frame.width / 2
        
        currentTimeView.text = getTodayString()
        
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
}
