//
//  Post.swift
//  Timeline
//
//  Created by Zach Steed on 11/3/15.
//  Copyright © 2015 NobleZ. All rights reserved.
//

import Foundation

struct Post: Equatable {
    
    var imageEndPoint: String 
    var caption: String?
    var username: String
    var comments = []
    var likes = []
    var identifier: String?
    
    init(imageEndPoint: String, caption: String?, username: String, identifier: String?) {
        
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