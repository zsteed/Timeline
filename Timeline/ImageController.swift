//
//  ImageController.swift
//  Timeline
//
//  Created by Zach Steed on 11/4/15.
//  Copyright © 2015 NobleZ. All rights reserved.
//

import Foundation
import UIKit

class ImageController {
    
    //note: We use an identifier for the image instead of a URL because we are uploading to Firebase. If we were uploading to Amazon S3 or other cloud service, we would probably return a URL instead of identifier.
    static func uploadImage(image: UIImage, completion: (identifier: String) -> Void) {
        completion(identifier: "-K1l4125TYvKMc7rcp5e")
    }
    
    static func imageForIdentifier(identifier: String, completion: (image: UIImage?) -> Void) {
        completion(image: UIImage(named: "MockPhoto"))
    }
    
    
}






