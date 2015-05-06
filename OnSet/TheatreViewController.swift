//
//  TheatreViewController.swift
//  OnSet
//
//  Created by Kaloyan Popzlatev on 5/6/15.
//  Copyright (c) 2015 Charles Woodward. All rights reserved.
//


import UIKit
class TheatreViewController: UIViewController {
    @IBOutlet weak var googleMap: UIWebView!

    var locationManager:CLLocationManager = CLLocationManager()
    var link:String="https://www.google.com/maps/search/movie+theater+near+Ithaca,+NY/@42.4422877,-76.4983749,13z/data=!3m1!4b1"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.viewDidLoad()

        //self.navigationController?.navigationItem.setRightBarButtonItem(backButton, animated: true)
        self.navigationController!.navigationBar.translucent=false
        self.navigationController!.view.backgroundColor=UIColor.clearColor()
        self.navigationController!.navigationBar.backgroundColor=UIColor.clearColor()
        let url = NSURL(string: link)
        println(url)
        let request = NSURLRequest(URL:url!)
        googleMap.loadRequest(request)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
