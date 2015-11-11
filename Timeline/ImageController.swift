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
    
    static func uploadImage(image: UIImage, completion: (identifier: String?) -> Void) {
        
        if let base64Image = image.base64String {
            let base = FirebaseController.base.childByAppendingPath("images").childByAutoId()
            base.setValue(base64Image)
            completion(identifier: base.key)
        } else {
            completion(identifier: nil)
        }
    }
    
    static func imageForIdentifier(identifier: String, completion: (image: UIImage?) -> Void) {
        FirebaseController.dataAtEndpoint("images/\(identifier)") { (data) -> Void in
            if let data = data as? String {
                let image = UIImage(base64: data)
                completion(image: image)
            } else {
                completion(image: nil)
            }
        }
    }
    
    
}

extension UIImage {
    
    var base64String: String? {
        guard let data = UIImageJPEGRepresentation(self, 0.8) else {
            return nil
        }
        return data.base64EncodedStringWithOptions(.EncodingEndLineWithCarriageReturn)
    }
    
    convenience init?(base64: String) {
        if let imageData = NSData(base64EncodedString: base64, options: .IgnoreUnknownCharacters) {
            self.init(data: imageData)
        } else {
            return nil
        }
    }
}




