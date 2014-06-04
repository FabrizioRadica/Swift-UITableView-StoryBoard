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


    //remember UIButton *myButton=[UIButton Alloc] initWith.. etc etc]? :D
    //now:
    let myButton = UIButton(frame: CGRect(x: 10, y: 250, width: 120, height: 64))
    let color = UIColor(red: 0.5, green: 0.0, blue: 0.5, alpha: 1.0)
    var mioUrl = "http://blog-it.hostelbookers.com/wp-content/uploads/2012/08/pizza-patriottica.png"
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="DetailView"
        
        
    //Image
        var imgURL: NSURL = NSURL(string: mioUrl)
        var imgData: NSData = NSData(contentsOfURL: imgURL)
        let imageDetail=UIImageView(frame: CGRect(x: 0, y: 64, width: 320, height: 300))
        imageDetail.image=UIImage(data: imgData)
        self.view.addSubview(imageDetail)
        
    //Button
        let myControlEvt: UIControlEvents = UIControlEvents.TouchUpInside
        myButton.addTarget(self, action:Selector.convertFromStringLiteral("tappedButton:"), forControlEvents: myControlEvt)
        myButton.setTitle("I'm a button >", forState: UIControlState.Normal)
        myButton.backgroundColor=color
        // Obj-C: [self.view addSubview:myButton]
        self.view.addSubview(myButton)
        
    //text
        let textScroll = UITextView(frame: CGRect(x: 10, y: 80, width: 180, height: 150))
        textScroll.text="Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"
        textScroll.backgroundColor=UIColor(white: 0.0, alpha: 0.5)
        textScroll.textColor=UIColor(white: 1.0, alpha: 1.0)
        textScroll.editable=false
        self.view.addSubview(textScroll)

    }
    
    func tappedButton(sender: UIButton!) {
        performSegueWithIdentifier("buttonPressedView", sender: self.view)
        println("Tasto Premuto")
    }
}