//
//  MovieDetailViewController.swift
//  OnSet
//
//  Created by lab on 4/5/15.
//  Copyright (c) 2015 Charles Woodward. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var MovieLabel: UILabel!
    
    var movieInfo: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail: AnyObject = self.movieInfo {
            if let label = self.MovieLabel {
                label.text = detail.description
            }
        }
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