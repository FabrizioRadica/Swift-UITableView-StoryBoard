//
//  loadJson.swift
//  PrimoSwift
//
//  Created by fabrizio on 03/06/14.
//  Copyright (c) 2014 Fabrizio Radica. All rights reserved.
//

import Foundation
import UIKit

class loadjson: UIViewController,NSURLConnectionDelegate, NSURLConnectionDataDelegate{
    
    @IBOutlet var _title : UILabel
    @IBOutlet var _description : UITextView
    
    var data: NSMutableData = NSMutableData()
    var dataArray: NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="JSON Credits"
        startConnectionAt("http://www.radicadesign.com/file.json")
    }
    
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
        
        var rowData: NSDictionary = dataArray[1] as NSDictionary
        
        var title=rowData["title"] as String
        var description=rowData["description"] as String
        
        _title.text=title
        _description.text=description
    }
    
}