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
    
    var movies:[AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var user = PFUser.currentUser()
        if (PFUser.currentUser() != nil){
        var relation = user.relationForKey("tags")
            relation.query().findObjectsInBackgroundWithBlock{
                (objects:[AnyObject]!, error: NSError!) -> Void in
                if error != nil{
                    println(error)
                }else{
                    self.movies = objects
                    self.tableView.reloadData()
                }
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GoToMovieDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object:AnyObject = movies[indexPath.row]
                (segue.destinationViewController as MovieDetailViewController).movieInfo = object
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
        cell.movieTitle.text = object["title"] as? String
        cell.synopsis.text = object["synopsis"] as? String
        //cell.synopsis.font = UIFont.systemFontOfSize(10.0)
        
        let url:NSURL = NSURL(string: object["poster_thumbnail"] as String)!
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

