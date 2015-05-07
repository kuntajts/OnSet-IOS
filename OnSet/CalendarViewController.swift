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
    * Author: Kal Popzlatev
    * Function: viewDidLoad
    * Description: Initializes CLWeeklyCalendar and programatically adds a view for it; gets data from Parse
    *              and puts it in self.movies which is used to populate a table view
    * Param: -
    * Return: -
    * Properties modified: self.movies; calendarTable;
    * Precondition: -
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
        self.calendarTable.reloadData()
        println(self.movies)

        //self.updateReleaseDates()
        
        
        
        
        // Do any additional setup after loading the view.
    }
    

    /******************************************************
    * Author: Kal Popzlatev
    * Function: viewDidAppear
    * Description: animates view
    * Param: Bool: animated
    * Return: -
    * Properties modified: self.view
    * Precondition: -
    *******************************************************/
    override func viewDidAppear(animated: Bool) {
        //updateReleaseDates()
        if let user=PFUser.currentUser(){
            var relation = user.relationForKey("tags")
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
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /******************************************************
    * Author: Kal Popzlatev
    * Function: numberOfSectionsInTableView
    * Description: the table view is initialized with 1 section
    * Param: tableView
    * Return: 1
    * Properties modified: -
    * Precondition: -
    *******************************************************/
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    /******************************************************
    * Author: Kal Popzlatev
    * Function:tableView
    * Description:initializes a tableView with as many rows as tagged movies by the current user
    * Param: tableView, numberOfRowsInSection
    * Return: movies.count
    * Properties modified: -
    * Precondition: -
    *******************************************************/
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    /******************************************************
    * Author: Kal Popzlatev
    * Function: tableView
    * Description: populates table cells with poster image and a title for each movie
    * Param: tableView, indexPath
    * Return: cell
    * Properties modified: cell.releaseDate (label); cell.movieTitle (label); cell.thumbNailImage
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
        let url:NSURL = NSURL(string: (poster as? String)!)!    //uses internalhelper to download image in a
        InternalHelper.downloadImage(url, handler: {            //separate thread
            (image, error:NSError!) -> Void in
            cell.thumbnailImage.image = image
        })
        return cell
    }
    
    /******************************************************
    * Author: Kal Popzlatev
    * Function: tableView
    * Description: connects tableview to calendar. Once a row is selected the release date is indicated
    *              on the calendar view
    * Param: tableView, indexPath
    * Return: -
    * Properties modified: calendar's indicator tile
    * Precondition: -
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
