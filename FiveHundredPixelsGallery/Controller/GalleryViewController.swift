//
//  ViewController.swift
//  FiveHundredPixelsGallery
//
//  Created by Ahri on 10/10/17.
//  Copyright © 2017 hungMighty. All rights reserved.
//

import UIKit

struct ImageObj {
    var imageURL: String
    var imageName: String
    
    init(imageName: String, imageURL: String) {
        self.imageName = imageName
        self.imageURL = imageURL
    }
}

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mainLoadingView: UIView!
    @IBOutlet weak var galleryInfoIndicator: UIActivityIndicatorView!
    
    fileprivate let itemsPerRow = 2
    fileprivate let sectionInsets = UIEdgeInsetsMake(30, 20, 50, 20)
    fileprivate var photosJSON: [Any]?
    fileprivate var photoResources = [ImageObj]()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Roses Gallery"
        galleryInfoIndicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        galleryInfoIndicator.startAnimating()
        
        _ = PXRequest.init(forSearchTerm: "rose", searchTag: "flower", searchGeo: "",
                           page: 1, resultsPerPage: 60,
                           photoSizes: PXPhotoModelSize.large,
                           except: PXPhotoModelCategory.PXPhotoModelCategoryUncategorized,
                           completion: { (dict: Dictionary?, err: Error?) in
                            if let results = dict {
                                self.hanldingDictJson(json: results as! [String: Any])
                            } else {
                                self.showAlertMess()
                            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - API Handling
    
    func hanldingDictJson(json: Dictionary<String, Any>) {
        if json["photos"] != nil {
            photosJSON = json["photos"] as? [Any]
            
            if photosJSON != nil {
                for i in 0..<photosJSON!.count {
                    if let photoJSON = (photosJSON![i] as? [String: Any]) {
                        if (photoJSON["name"] as? String) != nil
                            && ((photoJSON["images"] as? [[String: Any]])?.last) != nil {
                            let nameStr = photoJSON["name"] as! String
                            let lastDict: [String: Any] = ((photoJSON["images"] as? [[String: Any]])?.last)!
                            if let urlStr = lastDict["url"] as? String {
                                let imageObj = ImageObj(imageName: nameStr, imageURL: urlStr)
                                photoResources.append(imageObj)
                            }
                        }
                    }
                }
                
                DispatchQueue.main.async {
                    self.mainLoadingView.isHidden = true
                    self.galleryInfoIndicator.stopAnimating()
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Actions
    
    
    // MARK: - General
    
    func showAlertMess() {
        let alert = UIAlertController(title: "Fail!", message: "No Photo received", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalPaddingSpace = sectionInsets.left * (CGFloat)(itemsPerRow + 1)
        let widthPerItem = (self.view.frame.size.width - totalPaddingSpace) / CGFloat(itemsPerRow);
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
}

extension GalleryViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoResources.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.cellIdentifier(), for: indexPath) as! ImageCell
        let imageResource = photoResources[indexPath.row]
        
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                cell.imageLoadingIndicator.startAnimating()
            }
            if let url = URL(string: imageResource.imageURL) {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    cell.imageLoadingIndicator.stopAnimating()
                    cell.imageLoadingIndicator.isHidden = true
                    cell.imageItem.image = UIImage(data: data!)
                }
            }
        }
        
        return cell
    }
    
}

extension GalleryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCell
        if cell.imageItem.image != nil {
            if let view = self.storyboard?.instantiateViewController(withIdentifier: DetailImageViewController.viewIdentifier) as? DetailImageViewController {
                view.imageToDisplay = cell.imageItem.image
                let imageName = photoResources[indexPath.row].imageName
                if !imageName.isEmpty {
                    view.imageTitle = imageName
                }
                self.navigationController?.pushViewController(view, animated: true)
            }
        }
    }
    
}

