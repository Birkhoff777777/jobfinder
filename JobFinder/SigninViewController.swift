//
//  SigninViewController.swift
//  JobFinder
//
//  Created by 杨鹏 on 4/20/15.
//  Copyright (c) 2015 pengyang. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController {
    
    @IBOutlet weak var Username: UITextField!
    
    @IBOutlet weak var Userpassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        Username.resignFirstResponder()
        Userpassword.resignFirstResponder()
    }
    
    @IBAction func loginButton(sender: AnyObject) {
        Username.resignFirstResponder()
        Userpassword.resignFirstResponder()
        if Username.text == "" || Userpassword.text == "" {
            var alertController1 = UIAlertController(title: "Invaild Name or Password", message: nil, preferredStyle: .Alert)
            
            var cancelAction = UIAlertAction(title: "Retry", style: .Cancel, handler: nil)
            
            alertController1.addAction(cancelAction)
            
            self.presentViewController(alertController1, animated: true, completion: nil)
        }
        else{
        let nsurl = NSURL(string: "https://jobfinder1.herokuapp.com/signin")
        var request = NSMutableURLRequest(URL: nsurl!)
        
        request.HTTPMethod = "POST"
        
        let postData: AnyObject = ["name": Username.text, "password": Userpassword.text]
        
        //let postString = "{name:test3,password:33333333}"
        let postString = JSONStringify(postData)
        println(postString)
        
        let data = postString.dataUsingEncoding(NSUTF8StringEncoding)
        println(data)
        request.HTTPBody = data
        println(request)
        var response:AutoreleasingUnsafeMutablePointer<NSURLResponse?> = nil
        var err:NSErrorPointer = nil
        var responseData = NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error: err)
        println(responseData)
        if err != nil{
            println(err)
        }else{
            //var responseStr:NSString = NSString(data:responseData!, encoding:NSUTF8StringEncoding)!
            
            var json : AnyObject? = NSJSONSerialization.JSONObjectWithData(responseData!, options: NSJSONReadingOptions.allZeros, error:nil)
            var state: NSNumber = json?.objectForKey("state") as! NSNumber
            println(json)
            if state == 0 {
                self.performSegueWithIdentifier("LoginSegue", sender: self)
            }
            else{
                var alertController1 = UIAlertController(title: "login name or password is wrong！", message: nil, preferredStyle: .Alert)
                var cancelAction = UIAlertAction(title: "Return", style: .Cancel, handler: nil)
                alertController1.addAction(cancelAction)
                self.presentViewController(alertController1, animated: true, completion: nil)
            }
        }
    }
}
    func JSONStringify(value: AnyObject, prettyPrinted: Bool = false) -> String {
        var options = prettyPrinted ? NSJSONWritingOptions.PrettyPrinted : nil
        if NSJSONSerialization.isValidJSONObject(value) {
            if let data = NSJSONSerialization.dataWithJSONObject(value, options: options, error: nil) {
                if let string = NSString(data: data, encoding: NSUTF8StringEncoding) {
                    return string as String
                }
            }
        }
        return ""
    }
}
