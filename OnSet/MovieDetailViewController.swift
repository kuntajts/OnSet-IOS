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
    
    @IBOutlet weak var MovieLabel: UILabel!
    
    var movieInfo: PFObject! {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func configureView() {
        print(movieInfo["title"])
        //MovieLabel.text = movieInfo["title"] as? String
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