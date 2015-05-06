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
    
    /******************************************************
    * Author: Jordan Smith
    * Function: viewDidLoad
    * Description: On Start-up the first screen that loads is changed from 
    *               FavoritesViewController to TagViewController
    * Param: -
    * Return: -
    * Properties modified: TagViewController is first view that user sees
    * Precondition:
    *******************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        //adding test movie
        self.tabBarController?.selectedIndex = 2
    }
    
    
    /******************************************************
    * Author: Jordan Smith
    * Function: viewDidAppear
    * Description: Querries Parse in order to obtained all movies tagged by the
    *              currently logged in user and populate tableView
    * Param: Bool:animated
    * Return: -
    * Properties modified: tableView is populated
    * Precondition: user needs to be logged in
    *******************************************************/
    override func viewDidAppear(animated: Bool) {
        var user = PFUser.currentUser()
        if (PFUser.currentUser() != nil){
            var relation = user!.relationForKey("tags")             //PFRelation object allows to maintain
            relation.query()!.findObjectsInBackgroundWithBlock{     //a list of movies for each user
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
    
    /******************************************************
    * Author: Jordan Smith
    * Function: prepareForSegue
    * Description: overrides perpareToSegue so that when a table cell is clicked the app
    *              opens the MovieDetailViewController for the specified movie
    * Param: segue with identifier "GoToMovieDetail"
    * Return: -
    * Properties modified: the information for the movie displayed in the selected cell
    *                       is passed to MovieDetailViewController
    * Precondition:
    *******************************************************/
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GoToMovieDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object:AnyObject = movies[indexPath.row]
                (segue.destinationViewController as? MovieDetailViewController)!.movieInfo = object as? PFObject
            }
        }
    }
    
    /******************************************************
    * Author:Jordan Smith
    * Function:numberOfSectionsInTableView
    * Description:table view has one section
    * Param: UITableView
    * Return: 1
    * Properties modified: -
    * Precondition: -
    *******************************************************/
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    /******************************************************
    * Author: Jordan Smith
    * Function: tableView
    * Description: defines the number of rows in the table as the number of movies
    *              tagged by the current user
    * Param: UITableView, section
    * Return: movies.count
    * Properties modified: -
    * Precondition: -
    *******************************************************/
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    /******************************************************
    * Author: Jordan Smith
    * Function: tableView
    * Description: populates a cell with specified movie information
    * Param: UITableView, cellForRowAtIndexPath
    * Return: cell
    * Properties modified:cell.releaseDate; cell.movieTitle; cell.thumbnailImage
    * Precondition:
    *******************************************************/
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

