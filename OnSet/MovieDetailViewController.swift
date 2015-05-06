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
    
    /******************************************************
    * Author: Sam Kamenetz
    * Function: configureView
    * Description: Querries Parse in order to obtain movie information after which
    *              User Interface labels are updated with the fetched data
    * Param: -
    * Return: -
    * Properties modified: navigationItem; titleLabel; directorLabel; releaseLabel;
    *            ratingLabel; plotTextView
    * Precondition: -
    *******************************************************/
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
    
    /******************************************************
    * Author: Sam Kamenetz
    * Function: getPosterImage
    * Description: Calls InternalHelper.downloadImage() and populates posterView with
    *              downloaded
    * Param: -
    * Return: -
    * Properties modified: posterView
    * Precondition: -
    *******************************************************/
    func getPosterImage() {
        var data: AnyObject?=movieInfo["Poster"]
        let url:NSURL = NSURL(string: data as! String)!
        InternalHelper.downloadImage(url, handler: {
            (image, error:NSError!) -> Void in         //new thread to get image
            self.posterView.image = image
        })
    }

    /******************************************************
    * Author: Sam Kamenetz
    * Function: viewDidLoad
    * Description: Customizes navigationBar and User Interface attributes
    *              calls self.configureView
    * Param: -
    * Return: -
    * Properties modified:
    * Precondition: user segues from TagViewController or FavoritesViewController
    *******************************************************/
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
    
    /******************************************************
    * Author: Sam Kamenetz
    * Function: prepareForSegue
    * Description: overrides prepareForSegue to segue to WebsiteViewController
    *              where a the movie website is opened
    * Param: segue with identifier "showWebsite"
    * Return: -
    * Properties modified: view is switched to WebsiteViewController
                           passes the movie information from MovieDetailViewController
    *                      to WebsiteViewController
    * Precondition:
    *******************************************************/
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showWebsite" {
            if let object:AnyObject = movieInfo {
                
                (segue.destinationViewController as? WebsiteViewController)!.movieInfo = object as? PFObject
            }
        }
    }

    
    
}