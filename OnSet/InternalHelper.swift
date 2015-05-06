//
//  InternetHelper.swift
//  OnSet
//
//  Created by lab on 4/8/15.
//  Author: Jordan Smith
//  Copyright (c) 2015 Charles Woodward. All rights reserved.
//

import Foundation
import UIKit

class InternalHelper {
    

    
    /******************************************************
    * Author: Jordan Smith
    * Function: downloadImage
    * Description: Uses a URL to download image for specific movie (creates a separate thread)
    * Param: url - link for image; handler
    * Return: -
    * Properties modified:
    * Precondition: URL must be included in Parse
    *******************************************************/
    
    class func downloadImage(url: NSURL!, handler: ((image: UIImage, NSError!) -> Void))
    {
        var imageRequest: NSURLRequest = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(imageRequest,     //initiate new thread for download
            queue: NSOperationQueue.mainQueue(),
            completionHandler:{response, data, error in
                handler(image: UIImage(data: data)!, error)
        })
    }
}
