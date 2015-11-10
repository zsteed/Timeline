//
//  User.swift
//  Timeline
//
//  Created by Zach Steed on 11/3/15.
//  Copyright © 2015 NobleZ. All rights reserved.
//

import Foundation

struct User: Equatable {
    
    private let kUsername = "username"
    private let kBio = "bio"
    private let kUrl = "url"
    
    var username: String
    var bio: String?
    var url: String?
    var identifier: String?
    var endpoint: String {
        return "users"
    }
    var jsonValue: [String:AnyObject] {
        var json: [String:AnyObject] = [kUsername: username]
        
        if let bio = bio {
            json.updateValue(bio, forKey: kBio)
        }
        if let url = url {
            json.updateValue(url, forKey: kUrl)
        }
        return json
    }
    
    init?(json: [String:AnyObject], identifier: String) {
        guard let username = json[kUsername] as? String else { return nil }
        
        self.username = username
        self.identifier = identifier
        self.bio = json[kBio] as? String
        self.url = json[kUrl] as? String 
    }
    
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

