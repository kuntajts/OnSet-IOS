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
    var dataSource = [AnyObject]()
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
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
                        
                        let parameters = ["screen_name" : "@wbpictures",
                            "include_rts" : "0",
                            "trim_user" : "1",
                            "count" : "50"]
                        
                        let postRequest = SLRequest(forServiceType:
                            SLServiceTypeTwitter,
                            requestMethod: SLRequestMethod.GET,
                            URL: requestURL,
                            parameters: parameters)
                        
                        postRequest.account = twitterAccount
                        
                        postRequest.performRequestWithHandler(
                            {(responseData: NSData!,
                                urlResponse: NSHTTPURLResponse!,
                                error: NSError!) -> Void in
                                var err: NSError?
                                self.dataSource = NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.MutableLeaves, error: &err) as! [AnyObject]
                                
                                if self.dataSource.count != 0 {
                                    dispatch_async(dispatch_get_main_queue()) {
                                        self.socialTable.reloadData()
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

