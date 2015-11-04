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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let destinationViewController = segue.destinationViewController as? LoginSignupViewController {
            
            if segue.identifier == "toLoginView" {
                destinationViewController.mode = .Login
            }
            
            if segue.identifier == "toSignupView" {
                destinationViewController.mode = .Signup
            }
        }
    }

    

}






