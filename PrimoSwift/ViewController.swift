//
//  ViewController.swift
//  PrimoSwift
//
//  Created by fabrizio on 03/06/14.
//  Copyright (c) 2014 Fabrizio Radica. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView : UITableView!
 
    var dataArray: NSArray = NSArray()
    var rowData: NSDictionary = NSDictionary()
    var refreshControl:UIRefreshControl!  // An optional variable
    //load JSON From URL
    var data: NSMutableData = NSMutableData()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title=kAppTitle
        
        refreshControlSetup()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "customCell")
        startConnectionAt(kJSONUrl)
    }
    
    func startConnectionAt(urlPath: String){
        var url: NSURL = NSURL(string: urlPath)!
        var request: NSURLRequest = NSURLRequest(URL: url)
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)!
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
        var dataAsString: NSString = NSString(data: self.data, encoding: NSUTF8StringEncoding)!
        var err: NSError
        var json: NSDictionary = NSJSONSerialization.JSONObjectWithData(self.data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        var results: NSArray = json["item"] as NSArray
        self.dataArray = results
        
        tableView.reloadData()
        println("eof...")
    }
    //end load JSONFrom URL
    
    func refreshControlSetup(){
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refersh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count;
    }
    
    func refresh(sender:AnyObject)
    {
        startConnectionAt(kJSONUrl)
        self.refreshControl.endRefreshing()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "miaCella"
        var cell: customCell! = self.tableView.dequeueReusableCellWithIdentifier(identifier ,forIndexPath: indexPath) as customCell

        /*
        if cell==nil {
            cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? customCell
        }*/

        rowData = dataArray[indexPath.row] as NSDictionary
        var title=rowData["title"] as String
        var subtitle=rowData["subtitle"] as String
        var image=rowData["thumb"] as String
        
        cell.miaImmagine.alpha=0.0
        cell.mioTesto.alpha=0.0
        cell.mioSubtitle.alpha=0.0
        
        var imageUrl = NSURL(string: image)
        var request = NSURLRequest(URL: imageUrl!)
        var requestQueue : NSOperationQueue = NSOperationQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: requestQueue, completionHandler:
            {(response: NSURLResponse!, responseData: NSData!, error: NSError!) -> Void in
                if error != nil {
                    println("error")
                }
                else {
                    dispatch_async(dispatch_get_main_queue(), {
                        cell.mioTesto.text = title
                        cell.mioSubtitle.text = subtitle
                        cell.miaImmagine.image=UIImage(data: responseData)
                        UIView.animateWithDuration(1.0,
                            delay: 0.0,
                            options: .CurveEaseInOut,
                            animations: {
                                cell.miaImmagine.alpha=1.0
                                cell.mioTesto.alpha=1.0
                                cell.mioSubtitle.alpha=1.0
                            },
                            completion: { finished in

                        })
                        
                    })
                }
        })
        return cell
    }
    

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Selected: \(indexPath.row)!")
        performSegueWithIdentifier("miaview", sender: self.view)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var index = self.tableView.indexPathForSelectedRow()
        if segue.identifier == "miaview" {
            var indexPath=index?.row
            let title: AnyObject?=dataArray.objectAtIndex(indexPath!).objectForKey("title")
            let description: AnyObject?=dataArray.objectAtIndex(indexPath!).objectForKey("description")
            let image: AnyObject?=dataArray.objectAtIndex(indexPath!).objectForKey("image")
            
            var destination = segue.destinationViewController as myViewController
            destination._title=title as String
            destination._description=description as String
            destination._imgUrl=image as String
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
