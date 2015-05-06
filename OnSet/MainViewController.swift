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
    
    /******************************************************
    * Author:
    * Function:
    * Description:
    * Param:
    * Return:
    * Properties modified:
    * Precondition:
    *******************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        //logoView.contentMode = UIViewContentMode.ScaleAspectFill
        //logoView.frame=CGRectOffset(logoView.frame, 200, 100);
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    /******************************************************
    * Author:
    * Function:
    * Description:
    * Param:
    * Return:
    * Properties modified:
    * Precondition:
    *******************************************************/
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    /******************************************************
    * Author:
    * Function:
    * Description:
    * Param:
    * Return:
    * Properties modified:
    * Precondition:
    *******************************************************/
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        setUpLogin()
    }
    
    /******************************************************
    * Author:
    * Function:
    * Description:
    * Param:
    * Return:
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
    * Author:
    * Function:
    * Description:
    * Param:
    * Return:
    * Properties modified:
    * Precondition:
    *******************************************************/
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /******************************************************
    * Author:
    * Function:
    * Description:
    * Param:
    * Return:
    * Properties modified:
    * Precondition:
    *******************************************************/
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {

        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /******************************************************
    * Author:
    * Function:
    * Description:
    * Param:
    * Return:
    * Properties modified:
    * Precondition:
    *******************************************************/
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        println("Failed to login...")
    }
    
    /******************************************************
    * Author:
    * Function:
    * Description:
    * Param:
    * Return:
    * Properties modified:
    * Precondition:
    *******************************************************/
    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?) {
        println("Failed to sign up...")
    }
    
    /******************************************************
    * Author:
    * Function:
    * Description:
    * Param:
    * Return:
    * Properties modified:
    * Precondition:
    *******************************************************/
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController) {
        println("User dismissed sign up.")
    }
    
    /******************************************************
    * Author:
    * Function:
    * Description:
    * Param:
    * Return:
    * Properties modified:
    * Precondition:
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
    
    /******************************************************
    * Author:
    * Function:
    * Description:
    * Param:
    * Return:
    * Properties modified:
    * Precondition:
    *******************************************************/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}