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
        
        ImageController.uploadImage(image) { (identifier) -> Void in
            if let identifier = identifier {
                var post = Post(imageEndPoint: identifier, caption: caption)
                post.save()
                completion(success: true, post: post)
            } else {
                completion(success: false, post: nil)
            }
        }
    }
    
    // not sure..
    static func postFromIdentifier(identifier: String, completion: (post: Post?) -> Void) {
        
        FirebaseController.dataAtEndpoint("posts/\(identifier)") { (data) -> Void in
            if let data = data as? [String:AnyObject] {
                let post = Post(json: data, identifier: identifier)
                completion(post: post)
            } else {
                completion(post: nil)
            }
        }
        
    }
    
    // if user wants to find all posts they have done
    static func postsForUser(user: User, completion: (post: [Post]?) -> Void) {
        
        FirebaseController.base.childByAppendingPath("posts").queryOrderedByChild("username").queryEqualToValue(user.username).observeSingleEventOfType(.Value, withBlock: { snapshot in
            if let postDictionaries = snapshot.value as? [String:AnyObject] {
                let posts = postDictionaries.flatMap({Post(json: $0.1 as! [String : AnyObject], identifier: $0.0)})
                let orderedPosts = orderPosts(posts)
                completion(post: orderedPosts)
            } else {
                completion(post: nil)
            }
        })
    }
    
    // deletes current post
    static func deletePost(post: Post) {
        post.delete()
    }
    
    // called when someones comments on a photo
    static func addCommentWithTextToPost(text: String, post: Post, completion: (success: Bool, post: Post?) -> Void) {
        
        if let postIdentifier = post.identifier {
            var comment = Comment(username: UserController.sharedController.currentUser.username, text: text, postIdentifier: postIdentifier)
            comment.save()
            
            PostController.postFromIdentifier(comment.postIdentifier){ (post) -> Void in
                completion(success: true, post: post)
            }
        } else {
            var post = post
            post.save()
            var comment = Comment(username: UserController.sharedController.currentUser.username, text: text, postIdentifier: post.identifier!)
            comment.save()
            PostController.postFromIdentifier(comment.postIdentifier) { (post) -> Void in
                completion(success: true, post: post)
        }
    }
    }
    
    // delete comment when called in post controller
    static func deleteComment(comment: Comment, completion: (success: Bool, post: Post?) -> Void) {
        comment.delete()
        PostController.postFromIdentifier(comment.postIdentifier) { (post) ->Void in
            completion(success: true, post: post)
        }
    }
    
    // called when like is pressed on post
    static func addLikeToPost(post: Post, completion: (success: Bool, post: Post?) -> Void) {
        if let postIdentifier = post.identifier {
            var like = Like(username: UserController.sharedController.currentUser.username, postIdentifier: postIdentifier)
            like.save()
        } else {
            var post = post
            post.save()
            var like = Like(username: UserController.sharedController.currentUser.username, postIdentifier: post.identifier!)
            like.save()
        }
        PostController.postFromIdentifier(post.identifier!, completion: { (post) -> Void in
            completion(success: true, post: post)
        })
    }
    
    // called when like is taken back from post
    static func deleteLike(like: Like, completion: (success: Bool, post: Post?) -> Void) {
        like.delete()
        PostController.postFromIdentifier(like.postIdentifier) { (post) -> Void in
            completion(success: true, post: post)
        }
    }
    
    static func orderPosts(posts: [Post]) -> [Post] {
        return posts.sort({$0.0.identifier > $0.1.identifier})
    }
    
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







