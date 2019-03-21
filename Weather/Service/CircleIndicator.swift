//
//  CircleIndicator.swift
//  Weather
//
//  Created by Olga Lidman on 21/03/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class CircleIndicator: UIView {

    @IBOutlet weak var circle1 : UIImageView!
    @IBOutlet weak var circle2 : UIImageView!
    @IBOutlet weak var circle3 : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        UIView.animateKeyframes(withDuration: 1.4, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.circle1.alpha = 0.1
        })
        UIView.animateKeyframes(withDuration: 1.4, delay: 0.7, options: [.repeat, .autoreverse], animations: {
            self.circle2.alpha = 0.1
        })
        UIView.animateKeyframes(withDuration: 1.4, delay: 1.4, options: [.repeat, .autoreverse], animations: {
            self.circle3.alpha = 0.1
        })
    }

}
