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
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as?
        UITableViewCell
        if (cell == nil) {
            cell! = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        }
        
        let object:AnyObject = movies[indexPath.row]
        cell!.textLabel?.text = object["title"] as? String
        cell!.detailTextLabel?.text = object["release_date"] as? String
        return cell!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

