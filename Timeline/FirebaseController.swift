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
    
    //note: The identifier will be used to identify the object on Firebase, and when nil, tells us that the object has not yet been saved to Firebase.
    var identifier: String? { get set }
    
    //note: The endpoint will determine where the object will be saved on Firebase.
    var endpoint: String { get }
    
    //note: A JSON representation of the object that will be saved to Firebase.
    var jsonValue: [String:AnyObject] { get }
    
    init?(json: [String: AnyObject], identifier: String)
    
    mutating func save()
    
    func delete()
    
}

extension FirebaseType {
    
    mutating func save() {
    
    var endpointBase: Firebase
        
    if let identifier = self.identifier {
        
        endpointBase = FirebaseController.base.childByAppendingPath(endpoint).childByAppendingPath(identifier)
    } else {
        endpointBase = FirebaseController.base.childByAppendingPath(endpoint).childByAutoId()
        
        self.identifier = endpointBase.key
        }
        endpointBase.updateChildValues(self.jsonValue)
    }
    
    func delete(){
        
        if let identifier = self.identifier {
            let endPointBase: Firebase = FirebaseController.base.childByAppendingPath(endpoint).childByAppendingPath(identifier)
            
            endPointBase.removeValue()
        }
    }
}















