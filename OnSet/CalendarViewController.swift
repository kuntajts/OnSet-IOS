//
//  CalendarViewController.swift
//  OnSet
//
//  Created by Charles Woodward on 3/22/15.
//  Copyright (c) 2015 Charles Woodward. All rights reserved.
//

import UIKit
import Parse

class CalendarViewController: UIViewController {
    var calendar:CLWeeklyCalendarView?
    var taggedMovie:PFObject!
    
    override func viewDidLoad() {
        //var calendar:CLWeeklyCalendarView
        super.viewDidLoad()
        calendar=CLWeeklyCalendarView(frame: CGRectMake(0,0,self.view.bounds.size.width,150))
        
        self.view.addSubview(calendar!)
        self.updateReleaseDates()
        
        
        
        
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func updateReleaseDates(){
        var user=PFUser.currentUser()
        var dateFinal:NSDate
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        var query = PFQuery(className:"Movies2")
        query.getObjectInBackgroundWithId("6oAdUGXXa9") {
            (movie, error) -> Void in
            if error == nil && movie != nil {
                self.taggedMovie=movie
                var myString=self.taggedMovie["Released"] as? String
                println(movie)
                println(myString)
                let date = dateFormatter.dateFromString(myString!)
                println(date)
                var relation = user!.relationForKey("tags")
                relation.addObject(self.taggedMovie)
                user!.saveInBackgroundWithBlock({
                    (success,error1) -> Void in
                    if(success){
                        println("saved")
                        self.calendar?.markDateSelected(date)
                    }else{
                        println("failed")
                        //self.calendar.
                    }
                })
            } else {
                println(error)
            }
        }

        
    }

}
