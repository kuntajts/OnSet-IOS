//
//  MainViewController.swift
//  OnSet
//
//  Created by lab on 4/5/15.
//  Copyright (c) 2015 Charles Woodward. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class MainViewController: UITabBarController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    var logoView=UIImageView(image: UIImage(named:"logo"))
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //logoView.contentMode = UIViewContentMode.ScaleAspectFill
        //logoView.frame=CGRectOffset(logoView.frame, 200, 100);
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    /******************************************************
    * Author: Jordan Smith
    * Function: viewDidAppear
    * Description: callse setUpLogin which brings up the login screen created by Parse
    * Param: Bool: animated
    * Return: -
    * Properties modified: -
    * Precondition: -
    *******************************************************/
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        setUpLogin()
    }
    
    /******************************************************
    * Author: Jordan Smith
    * Function: logInViewController
    * Description: instantiates parse login view
    * Param: PFLogInViewController, String: username, String: password
    * Return: true if strings are nill; false otherwise
    * Properties modified:
    * Precondition:
    *******************************************************/
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        
        
        if (!username.isEmpty || !password.isEmpty) {
            return true
        }else {
            return false
        }
        
    }
   
    /******************************************************
    * Author: Jordan Smith
    * Function: logInViewController
    * Description: closes login view from parse
    * Param: PFLoginViewController, user
    * Return: -
    * Properties modified: login view hidden
    * Precondition: user logged in
    *******************************************************/
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /******************************************************
    * Author: Jordan Smith
    * Function: signUpViewController
    * Description: dismisses login view controller if user signs up
    * Param: PFSignUpViewController, user
    * Return: -
    * Properties modified: sign up view is closed
    * Precondition: user signed up
    *******************************************************/
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {

        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /******************************************************
    * Author: Jordan Smith
    * Function: logInViewController
    * Description: If an error occured while loging in displays failed to login to the console
    * Param: PFLoginViewController, error
    * Return: -
    * Properties modified: -
    * Precondition: failed login
    *******************************************************/
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        println("Failed to login...")
    }
    
    /******************************************************
    * Author: Jordan Smith
    * Function: signUpViewController
    * Description: If an error occured while signing up displays error message to the console
    * Param: PFSignUpViewController, error
    * Return: -
    * Properties modified:
    * Precondition: failed to sign up
    *******************************************************/
    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?) {
        println("Failed to sign up...")
    }
    
    /******************************************************
    * Author: Jordan Smith
    * Function: signUpViewControllerDidCancelSignUp
    * Description: displays message to the console if user cancels sign up
    * Param: PFSignUpViewController
    * Return: -
    * Properties modified: -
    * Precondition: -
    *******************************************************/
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController) {
        println("User dismissed sign up.")
    }
    
    /******************************************************
    * Author: Jordan Smith
    * Function: setUpLogin
    * Description: initializes fields in login view controller and sign up view controller
    * Param: -
    * Return: displays view controller
    * Properties modified: view
    * Precondition: -
    *******************************************************/
    internal func setUpLogin() {
        if (PFUser.currentUser() == nil) {
            
            var logInViewController = PFLogInViewController()
            //logInViewController.view.backgroundColor = UIColor.blackColor()
            //logInViewController.logInView!.logo=logoView
            //logInViewController.logInView!.logo!.frame = CGRectOffset(logInViewController.logInView!.logo!.frame, 10, -100 )
            //logInViewController.logInView!.logo!.center = CGPointMake(200, 100);
            
            logInViewController.fields = PFLogInFields.UsernameAndPassword | PFLogInFields.LogInButton | PFLogInFields.SignUpButton | PFLogInFields.PasswordForgotten | PFLogInFields.Facebook
            
            logInViewController.delegate = self
            
            var signUpViewController = PFSignUpViewController()
            
            signUpViewController.delegate = self
            
            logInViewController.signUpController = signUpViewController
            
            self.presentViewController(logInViewController, animated: true, completion: nil)
            
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}