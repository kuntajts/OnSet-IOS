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
    
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var releaseLabel: UILabel?
    @IBOutlet weak var directorLabel: UILabel?
    @IBOutlet weak var ratingLabel: UILabel?
    @IBOutlet weak var plotTextView: UITextView?
    @IBOutlet weak var posterView: UIImageView!
    
    var movieInfo: PFObject! {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func configureView() {
        getPosterImage()
        self.navigationItem.title = movieInfo["Title"] as? String
        print(movieInfo)
        titleLabel?.text = movieInfo["Title"] as? String
        directorLabel?.text = movieInfo["Director"] as? String
        releaseLabel?.text = movieInfo["Released"] as? String
        ratingLabel?.text = movieInfo["imdbRating"] as? String
        //plotTextView?.text = movieInfo["Plot"] as? String
    }
    
    func getPosterImage() {
        let url:NSURL = NSURL(string: movieInfo["Poster"] as String)!
        InternalHelper.downloadImage(url, handler: {
            (image, error:NSError!) -> Void in
            self.posterView.image = image
        })
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}