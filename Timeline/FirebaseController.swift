//
//  FirebaseController.swift
//  Timeline
//
//  Created by Zach Steed on 11/9/15.
//  Copyright © 2015 NobleZ. All rights reserved.
//

import Foundation
import Firebase

class FirebaseController {
    
    static let base = Firebase(url: "fiery-inferno-7350.firebaseIO.com")
    
    static func dataAtEndpoint(endpoint: String, completion: (data:AnyObject?) -> Void) {
        
        let baseForEndPoint = FirebaseController.base.childByAppendingPath(endpoint)
        
        baseForEndPoint.observeSingleEventOfType(.Value, withBlock: { snapshot in
            if snapshot.value is NSNull {
                completion(data: nil)
            } else {
                completion(data: snapshot.value)
            }
        })
    }
    
    static func observeDataAtEndpoint(endpoint: String, completion: (data: AnyObject?) -> Void) {
        let baseForEndPoint = FirebaseController.base.childByAppendingPath(endpoint)
        baseForEndPoint.observeEventType(.Value, withBlock: { snapshot in
            if snapshot.value is NSNull {
                completion(data: nil)
            } else {
                completion(data: snapshot.value)
            }
        })
    }
}

protocol FirebaseType {
    
}















