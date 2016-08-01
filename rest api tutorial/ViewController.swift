//
//  ViewController.swift
//  rest api tutorial
//
//  Created by Madhu kiran Vemula on 7/21/16.
//  Copyright © 2016 harsha vemula. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableview: UITableView!
    var myArr : [NSDictionary] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loaddata()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell:MyTableViewCell = self.myTableview.dequeueReusableCellWithIdentifier("cell")! as! MyTableViewCell
    return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     
    }
    
    
    func loaddata(){
        let postEndpoint: String = "http://jsonplaceholder.typicode.com/posts/1"
        guard let url = NSURL(string: postEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = NSURLRequest(URL: url)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let todosEndpoint: String = "http://jsonplaceholder.typicode.com/todos"
        guard let todosURL = NSURL(string: todosEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let todosUrlRequest = NSMutableURLRequest(URL: todosURL)
        todosUrlRequest.HTTPMethod = "POST"
        let newTodo = ["title": "Frist todo", "body": "I iz fisrt", "userId": 1, "completed": false]
        let jsonTodo: NSData
        do {
            jsonTodo = try NSJSONSerialization.dataWithJSONObject(newTodo, options: [])
            todosUrlRequest.HTTPBody = jsonTodo
        } catch {
            print("Error: cannot create JSON from todo")
            return
        }
        todosUrlRequest.HTTPBody = jsonTodo
        
        
        let task = session.dataTaskWithRequest(todosUrlRequest) {
            (data, response, error) in
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            guard error == nil else {
                print("error calling POST on /todos/1")
                print(error)
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let receivedTodo = try NSJSONSerialization.JSONObjectWithData(responseData,options: []) as? [String: AnyObject] else {
                    print("Could not get JSON from responseData as dictionary")
                    return
                }
                print("The todo is: " + receivedTodo.description)
                
                guard let todoID = receivedTodo["id"] as? Int else {
                    print("Could not get todoID as int from JSON")
                    return
                }
                print("The ID is: \(todoID)")
            } catch  {
                print("error parsing response from POST on /todos")
                return
            }
        }
        task.resume()

    }
    
    func data_request(){
        
        let url:NSURL = NSURL(string: "http://jsonplaceholder.typicode.com/todos")!
        let Session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL:url)
        
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        let paramstring = "data=Hello"
        request.HTTPBody = paramstring.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task =  Session.dataTaskWithRequest(request) {
            (
            let data, let response, let error) in
            guard let  _:NSData = data, let _:NSURLResponse = response where error == nil else{
                print("error")
                return
            }
            let dataString = NSString(data :data!, encoding : NSUTF8StringEncoding)
            print(dataString)
            
            
            
        }
        task.resume()
        
    }
    
    func newfunc(){
        print("this is my func")
    }
    func somefunc(){
        print("harsha")
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
