//
//  CalendarViewController.swift
//  OnSet
//
//  Created by Charles Woodward on 3/22/15.
//  Copyright (c) 2015 Charles Woodward. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
    
    
    override func viewDidLoad() {
        var calendar:CLWeeklyCalendarView
        super.viewDidLoad()
        calendar=CLWeeklyCalendarView(frame: CGRectMake(0,0,self.view.bounds.size.width,150))
        
        self.view.addSubview(calendar)
        
        
        
        
        
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

}
