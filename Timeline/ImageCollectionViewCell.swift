//
//  ImageCollectionViewCell.swift
//  Timeline
//
//  Created by Zach Steed on 11/5/15.
//  Copyright © 2015 NobleZ. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func updateWithImageIdentifier(identifier: String) {
        
        ImageController.imageForIdentifier(identifier) { (image) -> Void in
            
        }
    }
    
}
