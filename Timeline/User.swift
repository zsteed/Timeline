//
//  User.swift
//  Timeline
//
//  Created by Zach Steed on 11/3/15.
//  Copyright © 2015 NobleZ. All rights reserved.
//

import Foundation

struct User: Equatable {
    
    var username: String
    var bio: String?
    var url: String?
    var identifier: String?
    
    init(username: String, bio: String?, url: String?, identifier: String?) {
        
        self.username = username
        self.bio = nil
        self.url = nil
        self.identifier = nil
        
    }
    
}

// compare username and identifier
func ==(lhs: User, rhs: User) -> Bool {
    
    return (lhs.username == rhs.username) && (lhs.identifier == rhs.identifier)
    
}

