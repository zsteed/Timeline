//
//  PostDetailTableViewController.swift
//  Timeline
//
//  Created by Zach Steed on 11/3/15.
//  Copyright © 2015 NobleZ. All rights reserved.
//

import UIKit

class PostDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var likesLable: UILabel!
    
    @IBAction func addCommentTapped(sender: AnyObject) {
        let commentAlert = UIAlertController(title: "Add Comment", message: nil, preferredStyle: .Alert)
        
        commentAlert.addTextFieldWithConfigurationHandler { (textfield) -> Void in
            textfield.placeholder = "Comment"
        }
        
        commentAlert.addAction(UIAlertAction(title: "Add Comment", style: .Default, handler: { (action) -> Void in
            if let text = commentAlert.textFields?.first?.text {
                PostController.addCommentWithTextToPost(text, post: self.post!, completion: { (success, post) -> Void in
                    if let post = post {
                        self.post = post
                        self.updateBasedOnPost()
                    }
                })
            }
        }))
        commentAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
        presentViewController(commentAlert, animated: true, completion: nil)
    }
    
    @IBAction func likeTapped(sender: AnyObject) {
    PostController.addLikeToPost(post!) { (success, post) -> Void in
        if let post = post {
            self.post = post
            self.updateBasedOnPost()
        }
        }
    }
    
    var post: Post?
    
    func updateBasedOnPost() {
        self.likesLable.text = "\(post?.likes.count) likes"
        self.commentsLabel.text = "\(post?.comments.count) comments"
        
        ImageController.imageForIdentifier(post!.imageEndPoint) { (image) -> Void in
            self.imageView.image = image
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateBasedOnPost()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return post!.comments.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath)
        
        let comment = post?.comments[indexPath.row]
        
        if let comment = comment {
            cell.textLabel?.text = comment.username
            cell.detailTextLabel?.text = comment.text
        }


        return cell
    }
    


}
