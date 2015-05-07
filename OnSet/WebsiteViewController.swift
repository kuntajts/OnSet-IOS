//
//  WebsiteViewController.swift
//  OnSet
//
//  Created by Kaloyan Popzlatev on 5/3/15.
//  Copyright (c) 2015 Charles Woodward. All rights reserved.
//

import Foundation
import Parse
class WebsiteViewController: UIViewController{
    @IBOutlet weak var movieWebsite: UIWebView!
    
    var movieInfo:PFObject!
    
    /******************************************************
    * Author: Charlie Woodward
    * Function: viewDidLoad
    * Description: navigation controller is programatically customized; 
    *              movieInfo is instantiated with data from MovieDetailViewController
    *              the URL used is kept in Parse for most movies
    * Param: -
    * Return: -
    * Properties modified: movieWebsite (webview)
    * Precondition: -
    *******************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title=movieInfo["Title"] as? String
        //self.navigationController?.navigationItem.setRightBarButtonItem(backButton, animated: true)
        self.navigationController!.navigationBar.translucent=false
        self.navigationController!.view.backgroundColor=UIColor.clearColor()
        self.navigationController!.navigationBar.backgroundColor=UIColor.clearColor()
        let url = NSURL(string: (movieInfo["Website"] as? String)!)
        println(url)
        let request = NSURLRequest(URL: url!)
        movieWebsite.loadRequest(request)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}