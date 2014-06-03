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
    let myButton = UIButton(frame: CGRect(x: 10, y: 100, width: 100, height: 50))
    let color = UIColor(red: 0.5, green: 0.0, blue: 0.5, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let myControlEvt: UIControlEvents = UIControlEvents.TouchUpInside
        myButton.addTarget(self, action:Selector.convertFromStringLiteral("tappedButton:"), forControlEvents: myControlEvt)
        myButton.setTitle("I'm a button", forState: UIControlState.Normal)
        myButton.backgroundColor=color

        // Obj-C: [self.view addSubview:myButton]
        self.view.addSubview(myButton)

    }
    
    func tappedButton(sender: UIButton!) {
        performSegueWithIdentifier("buttonPressedView", sender: self.view)
        println("Tasto Premuto")
    }
}