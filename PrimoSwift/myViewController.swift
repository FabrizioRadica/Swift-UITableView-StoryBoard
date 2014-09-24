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
    
    var _title:NSString = ""
    var _description:NSString = ""
    var _imgUrl:NSString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        //self.title=_title
        self.title="Pizza! :D"
        
        _label.text=_title
        _textView.text=_description

        var imgURL: NSURL = NSURL(string: self._imgUrl)
        var imgData: NSData = NSData(contentsOfURL: imgURL)
        
        dispatch_async(dispatch_get_main_queue(), {
            self._imageView.alpha=0.0
            self._imageView.image=UIImage(data: imgData)
            UIView.animateWithDuration(1.0,
                delay: 0.0,
                options: .CurveEaseInOut,
                animations: {
                    self._imageView.alpha=1.0
                },
                completion: { finished in
                    
            })
            

        })

    }

}