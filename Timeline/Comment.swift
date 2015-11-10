//
//  Comment.swift
//  Timeline
//
//  Created by Zach Steed on 11/3/15.
//  Copyright © 2015 NobleZ. All rights reserved.
//

import Foundation

struct Comment: Equatable, FirebaseType {
    
    private let kPost = "post"
    private let kuserName = "username"
    private let kText = "text"

    
    var username: String
    var text: String
    var postIdentifier: String
    var identifier: String?
    var endpoint: String {
        return "/posts/\(postIdentifier)/comments/"
    }
    
    var jsonValue: [String:AnyObject] {
        return [kPost: postIdentifier, kuserName: username, kText: text]
    }
    
    init(username: String, text: String, postIdentifier: String, identifier: String? = nil) {
        
        self.username = username
        self.text = text
        self.postIdentifier = postIdentifier
        self.identifier = nil
    }
    
    init?(json: [String:AnyObject], identifier: String) {
        guard let postIdentifier = json[kPost] as? String,
        let username = json[kuserName] as? String,
            let text = json[kText] as? String else { return nil }
        self.postIdentifier = postIdentifier
        self.username = username
        self.text = text
    }
    
}

func ==(lhs: Comment, rhs: Comment) -> Bool {
    
    return (lhs.username == rhs.username) && (lhs.identifier == rhs.identifier)
}




