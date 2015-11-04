//
//  LoginSignupPickerViewController.swift
//  Timeline
//
//  Created by Zach Steed on 11/3/15.
//  Copyright © 2015 NobleZ. All rights reserved.
//

import UIKit

class LoginSignupPickerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }

    

}



//Add a prepareForSegue() function, use the segue identifier to determine what mode to set on the destination view controller.

//note: You may need to add segue identifiers in Main.storyboard.

//Test your different modes to verify they work as expected, that the view is presented, and that the view is dismissed when the user successfully logs in or registers.



