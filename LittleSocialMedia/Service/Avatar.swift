//
//  Avatar.swift
//  Weather
//
//  Created by Olga Lidman on 17/03/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class Avatar: UIView {
    
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var photoView: UIImageView!
    
    override func awakeFromNib() {
        
        subView.clipsToBounds = false
        subView.layer.cornerRadius = layer.frame.width / 2
        subView.layer.shadowColor = UIColor.black.cgColor
        subView.layer.shadowOffset = .zero
        subView.layer.shadowOpacity = 0.7
        
        photoView.clipsToBounds = true
        photoView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        photoView.layer.borderWidth = 1
        photoView.layer.cornerRadius = layer.frame.width / 2
    }
}
