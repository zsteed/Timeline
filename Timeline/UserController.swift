//
//  UserController.swift
//  Timeline
//
//  Created by Zach Steed on 11/3/15.
//  Copyright © 2015 NobleZ. All rights reserved.
//

import Foundation

class UserController {
    
    static let sharedController = UserController()
    
    var currentUser: User! = UserController.mockUsers().first
    
    // links user and identifier
    static func userForIdentifier(identifier: String, completion: (user: User?) -> Void) {
        completion(user: mockUsers().first)
    }
    
    // optional array?, fetches all users from firebase?
    static func fetchAllUsers(completion: (user: [User]) -> Void) {
        completion(user: mockUsers())
    }
    
    // this is called when someone when someone wants to follow the current user
    static func followUser(user: String, completion: (success: Bool) -> Void) {
        completion(success: true)
    }
    
    // this will be called when the current user follows someone new
    static func userFollowsUser(user: String, secondUser: String, completion: (follows: Bool) -> Void) {
        completion(follows: true)
    }
    
    // optional array?, called when.. not sure..
    static func followedByUser(user: User, completion: (user: [User]?) -> Void) {
        completion(user: mockUsers())
    }
    
    //* note: Will be used to authenticate against our Firebase database of users.
    static func authenticateUser(email: String, password: String, completion: (success: Bool, user: User?) ->Void) {
        completion(success: true, user: mockUsers().first)
    }
    
    //* note: Will be used to create a user in Firebase.
    static func createUser(email: String, username: String, password: String, bio: String?, url: String?, completion: (success: Bool, user: User?) -> Void) {
        completion(success: true, user: mockUsers().first)
    }
    
    // update user info with new information?
    static func updateUser(user: User, username: String, bio: String?, url: String?, completion: (success: Bool, user: User?) -> Void) {
        completion(success: true, user: mockUsers().first)
    }
    
    // logs current user out if someone new wanted to log in
    static func logOutCurrentUser() {

    }
    
    static func mockUsers() -> [User] {
        
        let userArray = [
            User(username: "Thor", bio: "lives in another world", url: "something", identifier: "1234"),
            User(username: "Bilbo", bio: "Lives in the shire", url: "somethingelse", identifier: "5678"),
            User(username: "Tony", bio: "I'am Ironman", url: "somethingtoo", identifier: "7898")
            ]
    
        return userArray
    }
    
    
}





