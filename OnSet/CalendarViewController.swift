//
//  CalendarViewController.swift
//  OnSet
//
//  Created by Charles Woodward on 3/22/15.
//  Copyright (c) 2015 Charles Woodward. All rights reserved.
//

import UIKit
import Parse

class CalendarViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    var calendar:CLWeeklyCalendarView?
    var taggedMovie:PFObject!
    var movies:[PFObject] = []
    
    @IBOutlet weak var calendarTable: UITableView!
    
    /******************************************************
    * Author:
    * Function:
    * Description:
    * Param:
    * Return:
    * Properties modified:
    * Precondition:
    *******************************************************/
    override func viewDidLoad() {
        //var calendar:CLWeeklyCalendarView
        super.viewDidLoad()
        calendar=CLWeeklyCalendarView(frame: CGRectMake(0,0,self.view.bounds.size.width,150))
        calendarTable.dataSource=self
        calendarTable.delegate=self
        self.view.addSubview(calendar!)
        var user = PFUser.currentUser()
        if (PFUser.currentUser() != nil){
            var relation = user!.relationForKey("tags")
            relation.query()!.findObjectsInBackgroundWithBlock{
                (objects, error) -> Void in
                if error != nil{
                    println(error)
                }else{
                    self.movies = (objects as? [PFObject])!
                    self.calendarTable.reloadData()
                }
            }
        }
        println(self.movies)

        //self.updateReleaseDates()
        
        
        
        
        // Do any additional setup after loading the view.
    }

    /******************************************************
    * Author:
    * Function:
    * Description:
    * Param:
    * Return:
    * Properties modified:
    * Precondition:
    *******************************************************/
    override func viewDidAppear(animated: Bool) {
        //updateReleaseDates()
    }
    
    /******************************************************
    * Author:
    * Function:
    * Description:
    * Param:
    * Return:
    * Properties modified:
    * Precondition:
    *******************************************************/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /******************************************************
    * Author:
    * Function:
    * Description:
    * Param:
    * Return:
    * Properties modified:
    * Precondition:
    *******************************************************/
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    /******************************************************
    * Author:
    * Function:
    * Description:
    * Param:
    * Return:
    * Properties modified:
    * Precondition:
    *******************************************************/
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    /******************************************************
    * Author:
    * Function:
    * Description:
    * Param:
    * Return:
    * Properties modified:
    * Precondition:
    *******************************************************/
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:FavoritesViewCell = (tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as?
            FavoritesViewCell)!
        /*if (cell == nil) {
        cell! = FavoritesViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        }*/
        
        let object:PFObject = movies[indexPath.row] as PFObject
        cell.releaseDate.text = object["Released"] as? String
        cell.movieTitle.text = object["Title"] as? String
        
        var poster:AnyObject?=object["Poster"]
        let url:NSURL = NSURL(string: (poster as? String)!)!
        InternalHelper.downloadImage(url, handler: {
            (image, error:NSError!) -> Void in
            cell.thumbnailImage.image = image
        })
        return cell
    }
    
    /******************************************************
    * Author:
    * Function:
    * Description:
    * Param:
    * Return:
    * Properties modified:
    * Precondition:
    *******************************************************/
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!){
        var dateFinal:NSDate
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        println("in")
        let object:AnyObject = movies[indexPath.row]
        let date=object["Released"] as! String
        dateFinal = dateFormatter.dateFromString(date)!
        println(dateFinal)
        self.calendar?.redrawToDate(dateFinal)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    /*func updateReleaseDates(){
        var dateFinal:NSDate
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        println("in")
        if let indexPath = self.calendarTable.indexPathForSelectedRow() {
            let object:AnyObject = movies[indexPath.row]
            let date=object["Released"] as! String
            dateFinal = dateFormatter.dateFromString(date)!
            println(dateFinal)
            self.calendar?.redrawToDate(dateFinal)
        }
        
        //println(date)
        

        
    }*/

}
