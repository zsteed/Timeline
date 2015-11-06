//
//  PostTableViewCell.swift
//  Timeline
//
//  Created by Zach Steed on 11/6/15.
//  Copyright © 2015 NobleZ. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateWithPost(post: Post) {
        
        self.postImageView.image = nil
        
        self.commentsLabel.text = "\(post.comments.count) comments"
        self.likesLabel.text = "\(post.likes.count) likes"
        
        ImageController.imageForIdentifier(post.imageEndPoint) { (image) -> Void in
            self.postImageView.image = image
        }
    }

}
