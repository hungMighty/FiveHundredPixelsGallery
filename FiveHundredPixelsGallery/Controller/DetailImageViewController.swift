//
//  DetailImageViewController.swift
//  FiveHundredPixelsGallery
//
//  Created by Ahri on 10/11/17.
//  Copyright © 2017 hungMighty. All rights reserved.
//

import Foundation
import UIKit

class DetailImageViewController: UIViewController {
    
    static let viewIdentifier = "DetailImageViewController"
    
    @IBOutlet weak var displayImageView: UIImageView!
    
    var imageTitle: String?
    var imageToDisplay: UIImage?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if imageToDisplay != nil {
            self.displayImageView.image = imageToDisplay!
        }
        if imageTitle != nil {
            self.title = imageTitle!
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Actions
    
}
