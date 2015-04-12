//
//  FavoritesViewController.swift
//  OnSet
//
//  Created by Charles Woodward on 3/22/15.
//  Copyright (c) 2015 Charles Woodward. All rights reserved.
//

import UIKit
import Parse

class FavoritesViewController: UITableViewController {
    
    var movies:[PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var user = PFUser.currentUser()
        
        //adding test movie
        /*var query = PFQuery(className:"OMDBMovies")
        query.getObjectInBackgroundWithId("ytwItAwx0c") {
            (movie: PFObject!, error: NSError!) -> Void in
            if error == nil && movie != nil {
                println(movie)
                var relation = user.relationForKey("tags")
                relation.addObject(movie)
                user.saveInBackgroundWithBlock({
                    (success:Bool,error1: NSError!) -> Void in
                    if(success){
                        println("saved")
                    }else{
                        println("failed")
                    }
                })
            } else {
                println(error)
            }
        }*/
        
        if (PFUser.currentUser() != nil){
        var relation = user.relationForKey("tags")
            relation.query().findObjectsInBackgroundWithBlock{
                (objects:[AnyObject]!, error: NSError!) -> Void in
                if error != nil{
                    println(error)
                }else{
                    self.movies = objects as [PFObject]
                    self.tableView.reloadData()
                }
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func viewDidAppear(animated: Bool) {
        if (movies.count == 0) {
            var user = PFUser.currentUser()
            if (PFUser.currentUser() != nil){
                var relation = user.relationForKey("tags")
                relation.query().findObjectsInBackgroundWithBlock{
                    (objects:[AnyObject]!, error: NSError!) -> Void in
                    if error != nil{
                        println(error)
                    }else{
                        self.movies = objects as [PFObject]
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GoToMovieDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object:AnyObject = movies[indexPath.row]
                (segue.destinationViewController as MovieDetailViewController).movieInfo = object as PFObject
            }
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell {
        let cell:FavoritesViewCell = tableView!.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath!) as
        FavoritesViewCell
        /*if (cell == nil) {
            cell! = FavoritesViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        }*/
        
        let object:PFObject = movies[indexPath!.row] as PFObject
        cell.movieTitle.text = object["Title"] as? String
        print(object["Title"])
        cell.synopsis.text = object["Plot"] as? String
        //cell.synopsis.font = UIFont.systemFontOfSize(10.0)
        
        let url:NSURL = NSURL(string: object["Poster"] as String)!
        InternalHelper.downloadImage(url, handler: {
            (image, error:NSError!) -> Void in
            cell.thumbnailImage.image = image
        })
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

