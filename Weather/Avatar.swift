//
//  Avatar.swift
//  Weather
//
//  Created by Olga Lidman on 17/03/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class Avatar: UIView {
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    private var imageView: UIImageView!
    
    override func awakeFromNib() {
        imageView = UIImageView(frame: bounds)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        addSubview(imageView)
        
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.7
        layer.shadowColor = UIColor.black.cgColor
        layer.cornerRadius = layer.frame.width / 2
        
    }
}
