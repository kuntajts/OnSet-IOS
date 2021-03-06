//
//  ProfileViewController.swift
//  OnSet
//
//  Created by Charles Woodward on 3/22/15.
//  Copyright (c) 2015 Charles Woodward. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    
    /******************************************************
    * Author: Charlie Woodward
    * Function: viewDidLoad
    * Description: changes background image;
    * Param:-
    * Return:-
    * Properties modified:-
    * Precondition:-
    *******************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor(patternImage: UIImage(named:"background")!)
        // Do any additional setup after loading the view.
    
    }
    
    /******************************************************
    * Author: Charlie Woodward
    * Function: viewDidAppear
    * Description: displays a label with username for current user
    * Param: Bool: animated
    * Return: -
    * Properties modified: usernameLabel
    * Precondition: -
    *******************************************************/
    override func viewDidAppear(animated: Bool) {
        var user = PFUser.currentUser()
        var usernameData: AnyObject? = user!["username"]
        usernameLabel.text = usernameData as? String
    }
    
    
    /******************************************************
    * Author: Charlie Woodward
    * Function: logoutClicked
    * Description: logs current user out of the app
    * Param: sender UIButton
    * Return:
    * Properties modified: leads back to login screen
    * Precondition: button clicked
    *******************************************************/
    @IBAction func logoutClicked(sender: UIButton) {
        PFUser.logOut()
        var currentUser = PFUser.currentUser()
        let mainViewController = self.parentViewController as? MainViewController
        
        mainViewController!.setUpLogin()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
