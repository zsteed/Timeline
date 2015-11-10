//
//  Post.swift
//  Timeline
//
//  Created by Zach Steed on 11/3/15.
//  Copyright © 2015 NobleZ. All rights reserved.
//

import Foundation

struct Post: Equatable, FirebaseType {
    
    private let kImageEndPoint = "imageEndPoint"
    private let KCaption = "caption"
    private let kUsername = "username"
    private let kComments = "comments"
    private let kLikes = "likes"
    
    var imageEndPoint: String 
    var caption: String?
    var username: String
    var comments: [Comment]
    var likes: [Like]
    var identifier: String?
    var endpoint: String {
        return "posts"
    }
    var jsonValue: [String:AnyObject] {
        var json: [String:AnyObject] = [kUsername: username, kImageEndPoint: imageEndPoint, kComments: comments.map({$0.jsonValue}), kLikes: likes.map({$0.jsonValue})]
        if let caption = caption {
            json.updateValue(caption, forKey: KCaption)
        }
        return json
    }
    
    init?(json: [String:AnyObject], identifier: String) {
        guard let imageEndPoint = json[kImageEndPoint] as? String,
            let username = json[kUsername] as? String else { return nil }
        
        self.imageEndPoint = imageEndPoint
        self.caption = json[KCaption] as? String
        self.username = username
        self.identifier = identifier
        
        if let commentDictionaries = json[kComments] as? [String:AnyObject] {
            self.comments = commentDictionaries.flatMap({Comment(json: $0.1 as! [String:AnyObject], identifier: $0.0)})
        } else {
            self.comments = []
        }
        if let likesDictionaries = json[kLikes] as? [String:AnyObject] {
            self.likes = likesDictionaries.flatMap({Like(json: $0.1 as! [String:AnyObject], identifier: $0.0)})
        } else {
            self.likes = []
        }
        
    }
    
    init(imageEndPoint: String, caption: String?, username: String = "", identifier: String? = nil, comments: [Comment] = [], likes: [Like] = []) {
        
        self.imageEndPoint = imageEndPoint
        self.caption = nil
        self.username = username
        self.comments = []
        self.likes = []
        self.identifier = nil
    }
    
    
}


func ==(lhs: Post, rhs: Post) -> Bool {
    
    return (lhs.username == rhs.username) && (lhs.identifier == rhs.identifier)
}