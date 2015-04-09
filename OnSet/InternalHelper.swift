//
//  InternetHelper.swift
//  OnSet
//
//  Created by lab on 4/8/15.
//  Copyright (c) 2015 Charles Woodward. All rights reserved.
//

import Foundation
import UIKit

class InternalHelper {
    
    class func dataToJson(data: NSData) -> NSDictionary
    {
        var error: NSError?
        var jsonDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
        return jsonDictionary
    }
    
    class func downloadImage(url: NSURL!, handler: ((image: UIImage, NSError!) -> Void))
    {
        var imageRequest: NSURLRequest = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(imageRequest,
            queue: NSOperationQueue.mainQueue(),
            completionHandler:{response, data, error in
                handler(image: UIImage(data: data)!, error)
        })
    }
}
