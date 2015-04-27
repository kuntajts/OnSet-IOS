//
//  TagDetailViewController.swift
//  OnSet
//
//  Created by Kaloyan Popzlatev on 4/26/15.
//  Copyright (c) 2015 Charles Woodward. All rights reserved.
//

import Foundation
import UIKit
import Parse
class TagDetailViewController: UIViewController {
    
    @IBOutlet weak var findTheatreButton: UIButton!
    @IBOutlet weak var watchTrailerButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var releaseLabel: UILabel?
    @IBOutlet weak var directorLabel: UILabel?
    @IBOutlet weak var ratingLabel: UILabel?
    @IBOutlet weak var plotTextView: UITextView?
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var backButton: UIBarButtonItem!

    
    
    var movieInfo: PFObject!
    
    func configureView() {
        
        getPosterImage()
        
                //print(movieInfo)
        
        //self.navigationItem.title = movieInfo["Title"] as? String
        self.navigationController?.navigationItem.setLeftBarButtonItem(backButton, animated: true)
        titleLabel?.text = movieInfo["Title"] as? String
        directorLabel?.text = movieInfo["Director"] as? String
        releaseLabel?.text = movieInfo["Released"] as? String
        ratingLabel?.text = movieInfo["imdbRating"] as? String
        plotTextView?.text = movieInfo["Plot"] as? String
    }
    
    func getPosterImage() {
        var data: AnyObject?=movieInfo["Poster"]
        let url:NSURL = NSURL(string: data as! String)!
        InternalHelper.downloadImage(url, handler: {
            (image, error:NSError!) -> Void in
            self.posterView?.image = image
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = movieInfo["Title"] as? String
        self.navigationItem.setRightBarButtonItem(backButton, animated: true)
        //self.navigationItem.setNavigationItemHidden(false, animated: false)
        plotTextView?.clipsToBounds = true
        plotTextView?.layer.cornerRadius = 4.0
        findTheatreButton?.clipsToBounds = true
        findTheatreButton?.layer.cornerRadius = 4.0
        watchTrailerButton?.clipsToBounds = true
        watchTrailerButton?.layer.cornerRadius = 4.0
        //self.navigationController?.setNavigationBarHidden(false, animated:true)
        var myBackButton:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        myBackButton.addTarget(self, action: "popToRoot:", forControlEvents: UIControlEvents.TouchUpInside)
        myBackButton.setTitle("YOUR TITLE", forState: UIControlState.Normal)
        myBackButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        myBackButton.sizeToFit()
        var myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: myBackButton)
        self.navigationItem.leftBarButtonItem  = myCustomBackButtonItem
        
        self.configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func buttonClicked(){
        
    }
}
