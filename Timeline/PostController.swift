//
//  PostController.swift
//  Timeline
//
//  Created by Zach Steed on 11/3/15.
//  Copyright © 2015 NobleZ. All rights reserved.
//

import Foundation

class PostController {
    
    // when use clicks homepage this function will be called from firebase to update current timeline
    static func fetchTimelineForUser(user: User, completion: (post: [Post]) -> Void) {
        
    }
    
    // function is called when image and text is added and they click post, it will post to timeline
    static func addPost(image: String, caption: String?, completion: (success: Bool, post: Post?) -> Void) {
        
    }
    
    // not sure..
    static func postFromIdentifier(identifier: String, completion: (post: Post?) -> Void) {
        
    }
    
    // if user wants to find all posts they have done
    static func postsForUser(user: User, completion: (post: [Post]?) -> Void) {
        
    }
    
    // deletes current post
    static func deletePost(post: Post) {
        
    }
    
    // called when someones comments on a photo
    static func addCommentWithTextToPost(string: String, post: Post, completion: (success: Bool, post: Post?) -> Void) {
        
    }
    
}

//8. Define a static function `deleteComment` that takes a `Comment` and completion closure with a success Boolean parameter and optional `Post` parameter.

//9. Define a static function `addLikeToPost` that takes a `Post`, and completion closure with a success Boolean parameter and optional `Post` parameter.
//10. Define a static function `deleteLike` that takes a `Like` and completion closure with a success Boolean parameter and optional `Post` parameter.
//11. Define a static function `orderPosts` that takes an array of `Post` objects and returns a sorted array of `Post` objects. For now, return an empty array.
//    12. Define a static function `mockPosts()` function that returns an array of sample posts.
//13. Implement the `mockPosts()` function by returning an array of at least 3 initalized posts.
//* note: Use a static string `-K1l4125TYvKMc7rcp5e` as the sample image identifier.
//14. Use the `mockPosts()` function to implement staged completion closures in the rest of your static functions.






