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
    @IBOutlet weak var synopsis: UITextView! = UITextView()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        synopsis.editable = true
        synopsis.font = UIFont.systemFontOfSize(10.0)
        synopsis.clipsToBounds = true
        synopsis.layer.cornerRadius = 4.0
        synopsis.textColor = UIColor.whiteColor()
        synopsis.editable = false
        
        thumbnailImage.clipsToBounds = true
        thumbnailImage.layer.cornerRadius = 4.0
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
