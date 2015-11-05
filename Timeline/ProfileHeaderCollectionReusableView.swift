//
//  ProfileHeaderCollectionReusableView.swift
//  Timeline
//
//  Created by Zach Steed on 11/5/15.
//  Copyright © 2015 NobleZ. All rights reserved.
//

import UIKit

protocol ProfileHeaderCollectionReusableViewDelegate {
    
    func userTappedFollowActionButton()
    func userTappedUrlButton()
}

class ProfileHeaderCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var homepageButton: UIButton!
    @IBOutlet weak var followButton: UIButton!
    
    var delegate: ProfileHeaderCollectionReusableViewDelegate?
    
    func updateWithUser(user: User) {
        if let bio = user.bio {
            bioLabel.text = bio
        } else {
            bioLabel.hidden = false
        }
        
        if let url = user.url {
            homepageButton.setTitle(url, forState: .Normal)
        } else {
            homepageButton.hidden = true
        }
        
        if user == UserController.sharedController.currentUser {
            followButton.setTitle("Logout", forState: .Normal)
        } else {
            UserController.userFollowsUser(UserController.sharedController.currentUser, secondUser: user, completion: { (follows) -> Void in
                if follows {
                    self.followButton.setTitle("Unfollow", forState: .Normal)
                } else {
                    self.followButton.setTitle("Follow", forState: .Normal)
                }
            })
        }
    }
    
    @IBAction func urlButtonTapped() {
        delegate?.userTappedUrlButton()
    }
    
    @IBAction func followActionButtonTapped() {
        delegate?.userTappedFollowActionButton()
    }
        
}





