//
//  TimelineTableViewController.swift
//  Timeline
//
//  Created by Zach Steed on 11/3/15.
//  Copyright © 2015 NobleZ. All rights reserved.
//

import UIKit

class TimelineTableViewController: UITableViewController {

    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if let currentUser = UserController.sharedController.currentUser {
            if posts.count == 0 {
                loadTimeLineForUser(currentUser)
            } else {
                self.tabBarController?.performSegueWithIdentifier("tologinSignup", sender: nil)
            }
        }
    }
    
    func loadTimeLineForUser(user: User) {
        
        PostController.fetchTimelineForUser(user) { (posts) -> Void in
            if let posts = posts {
                self.posts = posts
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                })
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as! PostTableViewCell
        
        let post = posts [indexPath.row]
        
        cell.updateWithPost(post)

        return cell
    }
    
    @IBAction func userRefreshedTable() {
        loadTimeLineForUser(UserController.sharedController.currentUser)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toPostDetailView" {
            if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPathForCell(cell) {
                let post = posts[indexPath.row]
                let destinationViewController = segue.destinationViewController as? PostDetailTableViewController
                
                destinationViewController?.post = post 
            }
        }
    }

    
   

}





