//
//  LoginSignupViewController.swift
//  Timeline
//
//  Created by Zach Steed on 11/3/15.
//  Copyright © 2015 NobleZ. All rights reserved.
//

import UIKit

class LoginSignupViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    
    @IBAction func actionButtonTapped(sender: AnyObject) {
        if fieldsAreValid {
            switch mode {
            case .Login:
                UserController.authenticateUser(emailTextField.text!, password: passwordTextField.text!, completion: { (success, user) -> Void in
                    if success, let _ = user {
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                        self.presentValidationAlertWithTitle("Unable To Log In", message: "Please check your information and try again")
                }
            })
            case .Signup:
                UserController.createUser(emailTextField.text!, username: usernameTextField.text!, password: passwordTextField.text!, bio: bioTextField.text!, url: urlTextField.text!, completion: { (success, user) -> Void in
                    if success, let _ = user {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                        self.presentValidationAlertWithTitle("Unable to Signup", message: "Please check your information and try again")
                    }
                })
        }
                
        } else {
            presentValidationAlertWithTitle("Missing Information", message: "Please check your information and try again")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViewBasedOnMode()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    var mode: ViewMode = .Signup
    
    var fieldsAreValid: Bool {
        get {
            switch mode {
            case .Login:
                    return !(emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty)
            case .Signup:
                return !(emailTextField.text!.isEmpty || usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty)                
            }
        }
    }
    
    enum ViewMode {
        
        case Login
        case Signup
    }
    
    func updateViewBasedOnMode() {
        switch mode {
        case .Login:
            usernameTextField.hidden = true
            bioTextField.hidden = true
            urlTextField.hidden = true
            
            actionButton.setTitle("Login", forState: .Normal)
        case .Signup:
            actionButton.setTitle("Signup", forState: .Normal)
        }
        
    }
    
    func presentValidationAlertWithTitle(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        
        presentViewController(alert, animated: true, completion: nil)
    }
}














