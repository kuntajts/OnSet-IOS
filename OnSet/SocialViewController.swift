//
//  SocialViewController.swift
//  OnSet
//
//  Created by Charles Woodward on 3/22/15.
//  Copyright (c) 2015 Charles Woodward. All rights reserved.
//

import UIKit
import Social
import Accounts

class SocialViewController: UIViewController {
    @IBOutlet weak var socialTable: UITableView!
    var dataSource = [AnyObject]()                  //twitter feed
    
    /******************************************************
    * Author: Kal Popzlatev
    * Function: viewDidLoad
    * Description: programatically creates a table view
    *              calls self.getTimeLine()
    * Param: -
    * Return: -
    * Properties modified: adds tableView to the view controller
    * Precondition: -
    *******************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        self.socialTable.registerClass(UITableViewCell.self,
            forCellReuseIdentifier: "Cell")
        self.getTimeLine()
        // Do any additional setup after loading the view, typically from a nib.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /******************************************************
    * Author: Kal Popzlatev
    * Function: tableView
    * Description: initializes correct number of rows according
    *              to the length of the twitter feed (dataSource)
    * Param:    UITableView, numberOfRowsInSection
    * Return: dataSource.count
    * Properties modified: -
    * Precondition: dataSource is not nil
    *******************************************************/
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    
    /******************************************************
    * Author: Kal Popzlatev
    * Function: tableView
    * Description: populates cells with information from dataSource
    *              which is holding twitter posts
    * Param: UITableView; cellForRowAtIndexPath
    * Return: cell
    * Properties modified: cell, socialTable
    * Precondition: -
    *******************************************************/
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell =
        self.socialTable.dequeueReusableCellWithIdentifier("Cell")
            as! UITableViewCell
        let row = indexPath.row
        let tweet = self.dataSource[row] as! NSDictionary
        cell.textLabel!.text = tweet.objectForKey("text") as? String
        cell.textLabel!.numberOfLines = 0
        return cell
    }
    
    /******************************************************
    * Author: Kal Popzlatev
    * Function: getTimeLine
    * Description: gets access to the account currently logged on Twitter
    *              on the device and requests the latest 50 tweets from Paramount Pictures
    * Param: -
    * Return: -
    * Properties modified: dataSource
    * Precondition: the user needs to be logged into twitter on the device
    *******************************************************/
    func getTimeLine() {
        
        let account = ACAccountStore()
        let accountType = account.accountTypeWithAccountTypeIdentifier(
            ACAccountTypeIdentifierTwitter)
        
        account.requestAccessToAccountsWithType(accountType, options: nil,
            completion: {(success: Bool, error: NSError!) -> Void in
                
                if success {
                    let arrayOfAccounts =
                    account.accountsWithAccountType(accountType)
                    
                    if arrayOfAccounts.count > 0 {
                        let twitterAccount = arrayOfAccounts.last as! ACAccount
                        
                        let requestURL = NSURL(string:
                            "https://api.twitter.com/1.1/statuses/user_timeline.json")
    // URL used in the request is intended to return the entries in the time line for a specific user’s Twitter account
                        let parameters = ["screen_name" : "@ParamountPics",
                            "include_rts" : "0",
                            "trim_user" : "1",
                            "count" : "50"]
                        //get latest 50 tweets posted by paramount pictures
                        let postRequest = SLRequest(forServiceType:
                            SLServiceTypeTwitter,
                            requestMethod: SLRequestMethod.GET,
                            URL: requestURL,
                            parameters: parameters)
                    
                        postRequest.account = twitterAccount
                        
                        postRequest.performRequestWithHandler(              //HTTP request
                            {(responseData: NSData!,
                                urlResponse: NSHTTPURLResponse!,
                                error: NSError!) -> Void in
                                var err: NSError?
                                self.dataSource = NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.MutableLeaves, error: &err) as! [AnyObject]
                                
                                if self.dataSource.count != 0 {
                                    dispatch_async(dispatch_get_main_queue()) { //separate thread to populate
                                        self.socialTable.reloadData()           //socialTable (tableView)
                                    }
                                }
                        })
                    }
                } else {
                    println("Failed to access account")
                }
        })
    }
    


}

