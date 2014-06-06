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
    
    //load JSON From URL
    var data: NSMutableData = NSMutableData()
    func startConnectionAt(urlPath: String){
        var url: NSURL = NSURL(string: urlPath)
        var request: NSURLRequest = NSURLRequest(URL: url)
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)
        connection.start()
    }
    
    func connection(connection: NSURLConnection!, didFailWithError error: NSError!) {
        println("Connection failed.\(error.localizedDescription)")
    }
    
    func connection(connection: NSURLConnection, didRecieveResponse response: NSURLResponse)  {
        println("Recieved response")
    }
    
    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        self.data = NSMutableData()
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        self.data.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        var dataAsString: NSString = NSString(data: self.data, encoding: NSUTF8StringEncoding)
        var err: NSError
        var json: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        var results: NSArray = json["item"] as NSArray
        self.dataArray = results
        
        tableView.reloadData()
        println("eof...")
    }
    //end load JSONFrom URL
    
    
    //load JSONFrom mainBundle
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
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "customCell")
        
        
        // **** TRY ONE!!! *****
        //Load From URL...
        startConnectionAt("http://www.radicadesign.com/demo/appswift01/file.json")
        
        //Load FROM mainBoundle...
        //loadJSONFile()

    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count;
    }
    
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell:customCell = self.tableView.dequeueReusableCellWithIdentifier("miaCella") as customCell
    
        var rowData: NSDictionary = dataArray[indexPath.row] as NSDictionary
        var title=rowData["title"] as String
        var subtitle=rowData["subtitle"] as String
        var image=rowData["image"] as String
        
        //GDC
        var queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

        dispatch_async(queue, {
            
            cell.mioTesto.text = title
            cell.mioSubtitle.text = subtitle

            dispatch_async(dispatch_get_main_queue(), {
                cell.miaImmagine.image=UIImage(named: image)
                })
            })
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
