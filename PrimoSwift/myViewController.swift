//
//  myViewController.swift
//  PrimoSwift
//
//  Created by fabrizio on 03/06/14.
//  Copyright (c) 2014 Fabrizio Radica. All rights reserved.
//

import Foundation
import UIKit

class myViewController: UIViewController {
    
    @IBOutlet weak var _label: UILabel!
    @IBOutlet weak var _textView: UITextView!
    @IBOutlet weak var _imageView: UIImageView!
    @IBOutlet weak var _activity: UIActivityIndicatorView!
    
    var _title:NSString = ""
    var _description:NSString = ""
    var _imgUrl:NSString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.title=_title
        self.title=kAppDetail
        
        _label.text=_title
        _textView.text=_description
        self._imageView.alpha=0.0
        var imageUrl = NSURL(string: self._imgUrl)
        var request = NSURLRequest(URL: imageUrl!)
        var requestQueue : NSOperationQueue = NSOperationQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: requestQueue, completionHandler:
            {(response: NSURLResponse!, responseData: NSData!, error: NSError!) -> Void in
                if error != nil {
                    println("error")
                }
                else {
                    dispatch_async(dispatch_get_main_queue(), {
                        self._imageView.image=UIImage(data: responseData)
                        UIView.animateWithDuration(0.5,
                            delay: 0.0,
                            options: .CurveEaseInOut,
                            animations: {
                                self._imageView.alpha=1.0
                            },
                            completion: { finished in
                                self._activity.stopAnimating()
                                
                        })
                        
                    })
                }
        })
        
        
    }

}