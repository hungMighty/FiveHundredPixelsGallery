//
//  RedBorderTxt.swift
//  FiveHundredPixelsGallery
//
//  Created by Ahri on 10/11/17.
//  Copyright © 2017 hungMighty. All rights reserved.
//

import Foundation
import UIKit

class RedBorderTxt: UITextField {
    
    var placeholderTxt = "Placeholder Text"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.textAlignment = .center
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.borderStyle = .none
        self.layer.cornerRadius = 15.0
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.red.cgColor
        
        let attributes = [
            NSAttributedStringKey.foregroundColor: UIColor.gray,
            NSAttributedStringKey.font : UIFont.italicSystemFont(ofSize: 15)
        ]
        self.attributedPlaceholder = NSAttributedString(string: placeholderTxt, attributes:attributes)
    }
    
}
