//
//  ProfileViewController.swift
//  Timeline
//
//  Created by Zach Steed on 11/3/15.
//  Copyright © 2015 NobleZ. All rights reserved.
//

import UIKit
import SafariServices

class ProfileViewController: UIViewController, UICollectionViewDataSource, ProfileHeaderCollectionReusableViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var user: User?
    var userPosts: [Post] = []
    
    func updateBasedOnUser() {
        guard let user = user else { return }
        
        title = user.username
        
        PostController.postsForUser(user) { (posts) -> Void in
            if let posts = posts {
                self.userPosts = posts
            } else {
                self.userPosts = []
            }
        }
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.collectionView.reloadData()
        }
            
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(user)
        if user == nil {
            user = UserController.sharedController.currentUser
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Collection Data Source
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPosts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("imageCell", forIndexPath: indexPath) as! ImageCollectionViewCell
        
        let post = userPosts[indexPath.row]
        
        cell.updateWithImageIdentifier(post.imageEndPoint)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView", forIndexPath: indexPath) as! ProfileHeaderCollectionReusableView
        
        headerView.updateWithUser(user!)
        headerView.delegate = self
        
        return headerView
    }
    
    func userTappedUrlButton() {
        if let profileUrl = NSURL(string: user!.url!) {
            let safariViewController = SFSafariViewController(URL: profileUrl)
            
            presentViewController(safariViewController, animated: true, completion: nil)
        }
    }
    
    func userTappedFollowActionButton() {
        guard let user = user else { return }
        
        if user == UserController.sharedController.currentUser {
            
            UserController.logOutCurrentUser()
            tabBarController?.selectedViewController = tabBarController?.viewControllers![0]
            
        } else {
            UserController.userFollowsUser(UserController.sharedController.currentUser, secondUser: user) { (follows) -> Void in
                
                if follows {
                    UserController.unfollowUser(self.user!, completion: { (success) -> Void in
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.updateBasedOnUser()
                        })
                    })
                } else {
                    UserController.followUser(self.user!, completion: { (success) -> Void in
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.updateBasedOnUser()
                        })
                    })
                }
            }
        }
    }
    

}





