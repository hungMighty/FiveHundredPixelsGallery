//
//  ImageCell.swift
//  FiveHundredPixelsGallery
//
//  Created by Ahri on 10/10/17.
//  Copyright © 2017 hungMighty. All rights reserved.
//

import Foundation
import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageItem: UIImageView!
    @IBOutlet weak var imageLoadingIndicator: UIActivityIndicatorView!
    
    static func cellIdentifier() -> String {
        return "ImageCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imageItem.contentMode = .scaleAspectFill
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}
