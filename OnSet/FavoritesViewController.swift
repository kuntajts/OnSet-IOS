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
        
        
        //adding test movie
        
        
        
        
    }

    override func viewDidAppear(animated: Bool) {
        var user = PFUser.currentUser()
        if (PFUser.currentUser() != nil){
            var relation = user!.relationForKey("tags")
            relation.query()!.findObjectsInBackgroundWithBlock{
                (objects, error) -> Void in
                if error != nil{
                    println(error)
                }else{
                    self.movies = (objects as? [PFObject])!
                    self.tableView.reloadData()
                }
            }
        }
        println(self.movies)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GoToMovieDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object:AnyObject = movies[indexPath.row]
                (segue.destinationViewController as? MovieDetailViewController)!.movieInfo = object as? PFObject
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
        let cell:FavoritesViewCell = (tableView!.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath!) as?
        FavoritesViewCell)!
        /*if (cell == nil) {
            cell! = FavoritesViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        }*/
        
        let object:PFObject = movies[indexPath!.row] as PFObject
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

