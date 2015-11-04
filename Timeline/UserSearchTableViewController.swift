//
//  UserSearchTableViewController.swift
//  Timeline
//
//  Created by Zach Steed on 11/3/15.
//  Copyright © 2015 NobleZ. All rights reserved.
//

import UIKit

class UserSearchTableViewController: UITableViewController {

    var usersDataSource: [User] = []
    
    @IBOutlet weak var modeSegmentedControl: UISegmentedControl!
    
    enum ViewMode: Int {
        
        case Friends
        case All
        
        func users(completion: (user: [User]?) -> Void) {
            
            switch self {
            case .Friends: UserController.followedByUser(UserController.sharedController.currentUser, completion: { (followers) -> Void in
                completion(user: followers)
            })
                
            case .All: UserController.fetchAllUsers({ (users) -> Void in
                completion(user: users)
            })
            }
        }
    }
    
    var mode: ViewMode {
        return ViewMode(rawValue: modeSegmentedControl.selectedSegmentIndex)!
    }
    
    func updateViewBasedOnMode(mode: ViewMode) {
        
        mode.users { (users) -> Void in
            if let users = users {
                self.usersDataSource = users
            } else {
                self.usersDataSource = []
            }
            self.tableView.reloadData()
        }
    }
    @IBAction func selectedIndexChanged(sender: UISegmentedControl) {
        updateViewBasedOnMode(mode)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViewBasedOnMode(mode)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.usersDataSource.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("friendCell", forIndexPath: indexPath)
        
        let user = usersDataSource[indexPath.row]
        
        cell.textLabel?.text = user.username
        
        return cell
    }

}




