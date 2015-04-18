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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var user = PFUser.currentUser()
        var usernameData: AnyObject? = user!["username"]
        usernameLabel.text = usernameData as? String
    
    }

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
