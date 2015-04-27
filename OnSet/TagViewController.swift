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
    @IBOutlet weak var navBar:UINavigationBar!
    var audioRecorder:AVAudioRecorder?
    var taggedMovie:[PFObject!]=[]
    override func viewDidLoad() {
        super.viewDidLoad()
        let dirPaths=NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let docsDir=dirPaths[0] as! String
        let soundFilePath=docsDir.stringByAppendingPathComponent("sound.caf")
        let soundFileURL=NSURL(fileURLWithPath: soundFilePath)
        let recordSettings=[AVEncoderAudioQualityKey: AVAudioQuality.Min.rawValue,
            AVEncoderBitRateKey: 16,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.0]
        var error:NSError?
        audioRecorder = AVAudioRecorder(URL: soundFileURL,
            settings: recordSettings as [NSObject : AnyObject], error: &error)
        
        var user=PFUser.currentUser()
        var relation=user?.relationForKey("tags")
        relation!.query()!.findObjectsInBackgroundWithBlock{
            (objects, error) -> Void in
            if error != nil{
                println(error)
            }else{
                self.taggedMovie = (objects as? [PFObject])!
                
            }
        }
        

        
        // Do any additional setup after loading the view.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var recorder:AVAudioRecorder
        var duration:NSTimeInterval
        duration=30
        println("start")
        audioRecorder?.recordForDuration(duration)
        println("end")
        //recordForDuration(duration)
        
        if(segue.identifier=="showDetail"){
            (segue.destinationViewController as? TagDetailViewController)?.movieInfo=taggedMovie[0]
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func clickTag(){
        self.performSegueWithIdentifier("showDetail", sender: nil)
        var user = PFUser.currentUser()
        var relation:PFRelation!
        var query = PFQuery(className:"Movies2")
        query.getObjectInBackgroundWithId("R55D21xBrh") {
            (movie, error) -> Void in
            if error == nil && movie != nil {
                println(movie)
                relation = user?.relationForKey("tags")
                relation.addObject(movie!)
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
