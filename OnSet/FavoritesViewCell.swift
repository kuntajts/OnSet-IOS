//
//  FavoritesViewCell.swift
//  OnSet
//
//  Created by lab on 4/8/15.
//  Copyright (c) 2015 Charles Woodward. All rights reserved.
//

import UIKit

class FavoritesViewCell: UITableViewCell {
    @IBOutlet weak var movieTitle: UILabel! = UILabel()
    @IBOutlet weak var thumbnailImage: UIImageView! = UIImageView()
    @IBOutlet weak var releaseDate: UILabel!

    /******************************************************
    * Author: Charlie Woodward
    * Function: awakeFromNib
    * Description: Customizes the image views for each poster
    * Param: -
    * Return: -
    * Properties modified: thumbnailImage
    * Precondition: -
    *******************************************************/
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thumbnailImage.clipsToBounds = true
        thumbnailImage.layer.cornerRadius = 4.0
    }

    /******************************************************
    * Author: Charlie Woodward
    * Function: setSelected
    * Description: animates user selection
    * Param: Bool:selected ; Bool:animated
    * Return: -
    * Properties modified: -
    * Precondition:
    *******************************************************/
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
