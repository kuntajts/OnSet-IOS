//
//  TagViewController.swift
//  OnSet
//
//  Created by Charles Woodward on 3/22/15.
//  Copyright (c) 2015 Charles Woodward. All rights reserved.
//

import UIKit
import AVFoundation
import Parse

class TagViewController: UIViewController {
    @IBOutlet weak var tagButton:UIButton!
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    var audioRecorder:AVAudioRecorder?
    var taggedMovie:[PFObject!]=[] //list of tagged movies for current user
    var movie:PFObject!
    
    /******************************************************
    * Author: Kal Popzlatev
    * Function: viewDidLoad
    * Description: customizes navigation bar; initializes AVAudioRecorder and saves it to sound.caf;
    *              loads the movies tagged by the current user
    * Param: -
    * Return: -
    * Properties modified: navigationBar; taggedMovie
    * Precondition:
    *******************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController!.navigationBar.shadowImage=UIImage()
        self.navigationController!.navigationBar.translucent=true
        self.navigationController!.view.backgroundColor=UIColor.clearColor()
        self.navigationController!.navigationBar.backgroundColor=UIColor.clearColor()
        self.view.backgroundColor=UIColor(patternImage: UIImage(named:"background")!)
        let dirPaths=NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let docsDir=dirPaths[0] as! String
        let soundFilePath=docsDir.stringByAppendingPathComponent("sound.caf") //creates file for recorder
        let soundFileURL=NSURL(fileURLWithPath: soundFilePath)
        let recordSettings=[AVEncoderAudioQualityKey: AVAudioQuality.Min.rawValue,
            AVEncoderBitRateKey: 16,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.0] //set recorder settings
        var error:NSError?
        audioRecorder = AVAudioRecorder(URL: soundFileURL,
            settings: recordSettings as [NSObject : AnyObject], error: &error)
        var user=PFUser.currentUser()
        var relation=user?.relationForKey("tags")
        
        relation!.query()!.findObjectsInBackgroundWithBlock{     //gets movies tagged by current user
            (objects, error) -> Void in
            if error != nil{
                println(error)
            }else{
                self.taggedMovie = (objects as? [PFObject])!
                
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    /******************************************************
    * Author: Kal Popzlatev
    * Function: prepareForSegue
    * Description: segues to MovieDetailViewController once movie is identified
    * Param: segue with identifier showDetail
    * Return: -
    * Properties modified: -
    * Precondition: tagButton clicked
    *******************************************************/
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        
        /*addMovie("DrzfjyGN15")
        addMovie("Jk4bkX8Ycu")
        addMovie("m4ko9Qqkwe")
        addMovie("W1ZB1uD9YS")
        addMovie("7uF16sZ5bt")*/
        if(segue.identifier=="showDetail"){
            (segue.destinationViewController as? MovieDetailViewController)?.movieInfo=self.movie
        }
    }
    
    /******************************************************
    * Author: Jordan Smith
    * Function: delay
    * Description: opens a thread used to delay the transition between TagViewController
    *              and MovieDetailViewController
    * Param: Double: delay
    * Return:
    * Properties modified: -
    * Precondition: -
    *******************************************************/
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    /******************************************************
    * Author: Kal Popzlatev
    * Function: taggedPressed
    * Description: Records sound for 30 seconds; calls addMovie and performSegue
    * Param: sender
    * Return: -
    * Properties modified: statusLabel;
    * Precondition: tag button pressed
    *******************************************************/
    @IBAction func taggedPressed(sender: AnyObject) {
        
        var recorder:AVAudioRecorder
        var duration:NSTimeInterval
        duration=30
        audioRecorder?.recordForDuration(duration)
        var movieTitle=searchBar.text
        self.addMovie(movieTitle)
        
        self.statusLabel.text = "Analyzing Audio..."
        self.delay(5, closure: { () -> () in
            self.performSegueWithIdentifier("showDetail", sender: nil)
            self.statusLabel.text = ""
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /******************************************************
    * Author: Kal Popzlatev
    * Function: addMovie
    * Description: using a string for the title of a specific movie, it adds it in the Parse database
    *              for the specific user
    * Param: String: objectID
    * Return: -
    * Properties modified: Parse database for current user (PFRelation)
    * Precondition: -
    *******************************************************/
    func addMovie(objectID: String){
        self.searchBar.resignFirstResponder()
        var user = PFUser.currentUser()
        var relation:PFRelation!
        var query = PFQuery(className:"Movies2")
        query.whereKey("Title", equalTo: objectID)
        query.findObjectsInBackgroundWithBlock{
            (movie, error) -> Void in
            if error == nil && movie != nil {
                println(movie)
                relation = user?.relationForKey("tags")
                if let object: AnyObject=movie!.first {
                    self.movie=object as! PFObject
                    relation.addObject(object as! PFObject)
                }
                user!.saveInBackgroundWithBlock({
                    (success,error1) -> Void in
                    if(success){
                        println("saved")
                    }else{
                        println("failed")
                    }
                })
            } else {
                println(error)
            }
        }

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
