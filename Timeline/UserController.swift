//
//  UserController.swift
//  Timeline
//
//  Created by Zach Steed on 11/3/15.
//  Copyright © 2015 NobleZ. All rights reserved.
//

import Foundation

class UserController {
    
    private let kuser = "userKey"
    
    var currentUser: User! {
        get {
            
            guard let uid = FirebaseController.base.authData?.uid,
                let userDictionary = NSUserDefaults.standardUserDefaults().valueForKey(kuser) as? [String: AnyObject] else {
                    
                    return nil
            }
            
            return User(json: userDictionary, identifier: uid)
        }
        
        set {
            
            if let newValue = newValue {
                NSUserDefaults.standardUserDefaults().setValue(newValue.jsonValue, forKey: kuser)
                NSUserDefaults.standardUserDefaults().synchronize()
            } else {
                NSUserDefaults.standardUserDefaults().removeObjectForKey(kuser)
                NSUserDefaults.standardUserDefaults().synchronize()
            }
        }
    }
    
    static let sharedController = UserController()
    
    // links user and identifier
    static func userForIdentifier(identifier: String, completion: (user: User?) -> Void) {
      
        FirebaseController.dataAtEndpoint("users/\(identifier)") { (data) -> Void in
        
            if let json = data as? [String:AnyObject] {
                let user = User(json: json, identifier: identifier)
                completion(user: user)
            } else {
                completion(user: nil)
            }
        }
    }
    
    // optional array?, fetches all users from firebase?
    static func fetchAllUsers(completion: (users: [User]) -> Void) {
        
        FirebaseController.dataAtEndpoint("users") { (data) -> Void in
        
            if let json = data as? [String:AnyObject] {
                let users = json.flatMap({User(json: $0.1 as! [String:AnyObject], identifier: $0.0)})
                completion(users: users)
            } else {
                completion(users: [])
            }
        }
    }
    
    // this is called when someone when someone wants to follow the current user
    static func followUser(user: User, completion: (success: Bool) -> Void) {
        
        FirebaseController.base.childByAppendingPath("/users/\(sharedController.currentUser.identifier!)/follows/\(user.identifier!)").removeValue()
        
        completion(success: true)
    }
    
    static func unfollowUser(user: User, completion: (success: Bool) -> Void) {
        FirebaseController.base.childByAppendingPath("/users/\(sharedController.currentUser.identifier!)/follows/\(user.identifier!)").removeValue()
        
        completion(success: true)
    }
    
    // this will be called when the current user follows someone new
    static func userFollowsUser(user: User, secondUser: User, completion: (follows: Bool) -> Void) {
        
        FirebaseController.dataAtEndpoint("/users/\(user.identifier!)/follows/\(secondUser.identifier!)") { (data) -> Void in
            if let _ = data {
                completion(follows: true)
            } else {
                completion(follows: false)
            }
        }
    }
    
    // optional array?, called when.. not sure..
    static func followedByUser(user: User, completion: (followed: [User]?) -> Void) {
        FirebaseController.dataAtEndpoint("/users/\(user.identifier!)/follows/") { (data) -> Void in
            if let json = data as? [String:AnyObject]{
                var users: [User] = []
                for userJson in json {
                    userForIdentifier(userJson.0, completion: { (user) -> Void in
                        if let user = user {
                            users.append(user)
                            completion(followed: users)
                        }
                    })
                }
            } else {
                completion(followed: [])
            }
        }
    }
    
    //* note: Will be used to authenticate against our Firebase database of users.
    static func authenticateUser(email: String, password: String, completion: (success: Bool, user: User?) ->Void) {
        FirebaseController.base.authUser(email, password: password) { (error, response) -> Void in
            if error != nil {
                print("Unsuccessful login attempt.")
                completion(success: false, user: nil)
            } else {
                print("User ID: \(response.uid) authenticated successfully")
                UserController.userForIdentifier(response.uid, completion: { (user) -> Void in
                    if let user = user {
                        sharedController.currentUser = user
                    }
                    completion(success: true, user: user)
                })
            }
        }
    }
    
    //* note: Will be used to create a user in Firebase.
    static func createUser(email: String, username: String, password: String, bio: String?, url: String?, completion: (success: Bool, user: User?) -> Void) {
        
        FirebaseController.base.createUser(email, password: password) { (error, response) -> Void in
            if let uid = response["uid"] as? String {
                var user = User(username: username, uid: uid, bio: bio, url: url)
                user.save()
                
                
                authenticateUser(email, password: password, completion: { (success, user) -> Void in
                    completion(success: success, user: user)
                })
            } else {
                completion(success: false, user: nil)
            }
        }

    }
    
    // update user info with new information?
    static func updateUser(user: User, username: String, bio: String?, url: String?, completion: (success: Bool, user: User?) -> Void) {
        var updatedUser = User(username: user.username, uid: user.identifier!, bio: bio, url: url)
        updatedUser.save()
        
        UserController.userForIdentifier(user.identifier!) { (user) -> Void in
            if let user = user {
                sharedController.currentUser = user
                completion(success: true, user: user)
            } else {
                completion(success: false, user: nil)
            }
        }
    }
    
    // logs current user out if someone new wanted to log in
    static func logOutCurrentUser() {
        FirebaseController.base.unauth()
        UserController.sharedController.currentUser = nil
    }
    
    
}





