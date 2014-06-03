//
//  ViewController.swift
//  PrimoSwift
//
//  Created by fabrizio on 03/06/14.
//  Copyright (c) 2014 Fabrizio Radica. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView : UITableView
    
    var items:Dictionary<String,String>=["Pizza Margherita":"Tomato, mozzarella, oregano ","Pizza viennese":"tomato, mozzarella, German sausage, oregano, oil", "Pizza capricciosa":"mozzarella, tomato, mushrooms, artichokes, cooked ham, olives, oil"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "customCell")
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell:customCell = self.tableView.dequeueReusableCellWithIdentifier("miaCella") as customCell
        let menusPizza=Array(items.keys)
        let menusingredients=Array(items.values)
        
        cell.mioTesto.text =  menusPizza[indexPath.row]
        cell.mioSubtitle.text = menusingredients[indexPath.row];
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        performSegueWithIdentifier("miaview", sender: self.view)
        println("Hai selezionato: \(indexPath.row)!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
