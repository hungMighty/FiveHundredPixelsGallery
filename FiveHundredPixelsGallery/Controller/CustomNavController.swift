//
//  CustomNavController.swift
//  FiveHundredPixelsGallery
//
//  Created by Ahri on 10/10/17.
//  Copyright © 2017 hungMighty. All rights reserved.
//

import Foundation
import UIKit

class CustomNavController: UINavigationController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.navigationBar.barTintColor = UIColor.red
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white];
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        // hide back button text
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: .plain, target: nil, action: nil)
    }
    
}
