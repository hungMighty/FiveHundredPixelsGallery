//
//  SearchViewController.swift
//  FiveHundredPixelsGallery
//
//  Created by Ahri on 10/11/17.
//  Copyright © 2017 hungMighty. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var searchTxt: RedBorderTxt!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Search 500px"
        self.searchTxt.delegate = self
        self.searchTxt.placeholderTxt = "Default Query: Rose"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func startSearching() {
        var query = "Rose"
        if searchTxt.text != nil && !(searchTxt.text!.isEmpty) {
            query = searchTxt.text!
        }
        
        if let view = self.storyboard?.instantiateViewController(withIdentifier: GalleryViewController.viewIdentifier) as? GalleryViewController {
            view.searchQuery = query
            self.navigationController?.pushViewController(view, animated: true)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func touchSearchButton(_ sender: Any) {
       self.startSearching()
    }
    
    // MARK: Keyboard events
    
    override func touchesBegan(_: Set<UITouch>, with: UIEvent?) {
        self.searchTxt.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchTxt.resignFirstResponder()
        self.startSearching()
        
        return true
    }
    
}
