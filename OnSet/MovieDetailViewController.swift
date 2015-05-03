//
//  MovieDetailViewController.swift
//  OnSet
//
//  Created by lab on 4/5/15.
//  Copyright (c) 2015 Charles Woodward. All rights reserved.
//

import UIKit
import Parse

class MovieDetailViewController: UIViewController {
    
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
        self.navigationItem.title = movieInfo["Title"] as? String
        self.navigationController?.navigationItem.setRightBarButtonItem(backButton, animated: true)
        print(movieInfo)
        
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
            self.posterView.image = image
        })
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController!.navigationBar.shadowImage=UIImage()
        self.navigationController!.navigationBar.translucent=true
        self.navigationController!.view.backgroundColor=UIColor.clearColor()
        self.navigationController!.navigationBar.backgroundColor=UIColor.clearColor()
        self.view.backgroundColor=UIColor(patternImage: UIImage(named:"background")!)
        // Do any additional setup after loading the view, typically from a nib.
        plotTextView!.clipsToBounds = true
        plotTextView!.layer.cornerRadius = 4.0
        findTheatreButton!.clipsToBounds = true
        findTheatreButton!.layer.cornerRadius = 4.0
        watchTrailerButton!.clipsToBounds = true
        watchTrailerButton!.layer.cornerRadius = 4.0
        
        self.configureView()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showWebsite" {
            if let object:AnyObject = movieInfo {
                
                (segue.destinationViewController as? WebsiteViewController)!.movieInfo = object as? PFObject
            }
        }
    }

    
    
}