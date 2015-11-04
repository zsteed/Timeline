//
//  PostController.swift
//  Timeline
//
//  Created by Zach Steed on 11/3/15.
//  Copyright © 2015 NobleZ. All rights reserved.
//

import Foundation
import UIKit

class PostController {
    
    // when use clicks homepage this function will be called from firebase to update current timeline
    static func fetchTimelineForUser(user: User, completion: (post: [Post]?) -> Void) {
       completion(post: mockPosts())
    }
    
    // function is called when image and text is added and they click post, it will post to timeline
    static func addPost(image: UIImage, caption: String?, completion: (success: Bool, post: Post?) -> Void) {
        completion(success: true, post: mockPosts().first)
    }
    
    // not sure..
    static func postFromIdentifier(identifier: String, completion: (post: Post?) -> Void) {
        completion(post: mockPosts().first)
    }
    
    // if user wants to find all posts they have done
    static func postsForUser(user: User, completion: (post: [Post]?) -> Void) {
        completion(post: mockPosts())
    }
    
    // deletes current post
    static func deletePost(post: Post) {
        
    }
    
    // called when someones comments on a photo
    static func addCommentWithTextToPost(string: String, post: Post, completion: (success: Bool, post: Post?) -> Void) {
        completion(success: true, post: mockPosts().first)
    }
    
    // delete comment when called in post controller
    static func deleteComment(comment: String, Completion: (success: Bool, post: Post?) -> Void) {
        Completion(success: true, post: mockPosts().first)
    }
    
    // called when like is pressed on post
    static func addLikeToPost(post: Post, completion: (success: Bool, post: Post?) -> Void) {
        completion(success: true, post: mockPosts().first)
    }
    
    // called when like is taken back from post
    static func deleteLike(like: String, completion: (success: Bool, post: Post?) -> Void) {
        completion(success: true, post: mockPosts().first)
    }
    
    // not sure..
    static func orderPosts(post: [Post]) -> [Post] {
        return []
    }
    
    //13. Implement the `mockPosts()` function by returning an array of at least 3 initalized posts.
    //* note: Use a static string `-K1l4125TYvKMc7rcp5e` as the sample image identifier.
    static func mockPosts() -> [Post] {
        
        let sampleImageIdentifier = "-K1l4125TYvKMc7rcp5e"
        
//        let like1 = Like(username: "Bilbo", postIdentifier: "1234", identifier: "")
//        let like2 = Like(username: "Frodo", postIdentifier: "5678", identifier: "")
//        let like3 = Like(username: "Thor", postIdentifier: "9871", identifier: "")
//        
//        let comment1 = Comment(username: "Frodo", text: "sweeet", postIdentifier: "4554", identifier: "")
//        let comment2 = Comment(username: "Bilbo", text: "lets party", postIdentifier: "6678", identifier: "")
        
        let post1 = Post(imageEndPoint: sampleImageIdentifier, caption: "awesome photo", username: "Thor", identifier: "")
        let post2 = Post(imageEndPoint: sampleImageIdentifier, caption: "sweet photo", username: "Frodo", identifier: "")
        let post3 = Post(imageEndPoint: sampleImageIdentifier, caption: "good times", username: "Bilbo", identifier: "")
        
        return [post1, post2, post3]
    }
    
    
}







