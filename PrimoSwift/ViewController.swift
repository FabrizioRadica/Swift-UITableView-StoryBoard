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
    
    //var items:Dictionary<String,String>=["Pizza Margherita":"Tomato, mozzarella, oregano ","Pizza viennese":"tomato, mozzarella, German sausage, oregano, oil", "Pizza capricciosa":"mozzarella, tomato, mushrooms, artichokes, cooked ham, olives, oil"]
    
    var dataArray: NSArray = NSArray()
    
    
    func loadJSONFile(){
        var filePath=NSBundle.mainBundle().pathForResource("file", ofType: "json")
        var err: NSError
        var jsonData : NSData=NSData.dataWithContentsOfMappedFile(filePath) as NSData
        var json: NSDictionary = NSJSONSerialization.JSONObjectWithData(jsonData as NSData, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        var results: NSArray = json["item"] as NSArray
        self.dataArray = results  
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Home TableView"
        
        loadJSONFile()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "customCell")
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        //return self.items.count;
        return self.dataArray.count;
    }
    
    /* WIP ... ??!
    func dispatch_async(queue: dispatch_queue_t!,((UInt) -> Void)!){
        println("GCD")
        
    }*/
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell:customCell = self.tableView.dequeueReusableCellWithIdentifier("miaCella") as customCell
        //let menusPizza=Array(items.keys)
        //let menusingredients=Array(items.values)
        var rowData: NSDictionary = dataArray[indexPath.row] as NSDictionary
        cell.mioTesto.text = rowData["title"] as String
        cell.mioSubtitle.text = rowData["subtitle"] as String;
        cell.miaImmagine.image=UIImage(named: rowData["image"] as String)
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
