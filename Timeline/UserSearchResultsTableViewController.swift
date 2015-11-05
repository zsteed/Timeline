//
//  UserSearchResultsTableViewController.swift
//  Timeline
//
//  Created by Zach Steed on 11/4/15.
//  Copyright © 2015 NobleZ. All rights reserved.
//

import UIKit

class UserSearchResultsTableViewController: UITableViewController {

    
    var usersResultsDataSource: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return usersResultsDataSource.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("userResultCell", forIndexPath: indexPath)
        
        let user = usersResultsDataSource[indexPath.row]
        
        cell.textLabel?.text = user.username

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        self.presentingViewController?.performSegueWithIdentifier("toProfileView", sender: cell)
    }
    



}
