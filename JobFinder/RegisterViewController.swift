//
//  RegisterViewController.swift
//  JobFinder
//
//  Created by 杨鹏 on 4/20/15.
//  Copyright (c) 2015 pengyang. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var Regisname: UITextField!
    
    
    @IBOutlet weak var Regispassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        Regisname.resignFirstResponder()
        Regispassword.resignFirstResponder()
    }
    
    @IBAction func RegisterBtn(sender: AnyObject) {
        if checkName(){
            
            let nsurl = NSURL(string: "https://jobfinder1.herokuapp.com/signon")
            
            
            
            //let nsurl = NSURL(string: "http://localhost:8080/JobFinderServer//signon")
            
            var request = NSMutableURLRequest(URL: nsurl!)
            
            
            request.HTTPMethod = "POST"
            
            
            
            let postData: AnyObject = ["name": Regisname.text, "password": Regispassword.text]
            
            
            
            let postString = JSONStringify(postData)
            
            println(postString)
            
            
            
            let data = postString.dataUsingEncoding(NSUTF8StringEncoding)
            
            println(data)
            
            request.HTTPBody = data
            
            println(request)
            
            var response:AutoreleasingUnsafeMutablePointer<NSURLResponse?> = nil
            
            var err:NSErrorPointer = nil
            
            var responseData = NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error: err)
            
            
            
            if err != nil{
                
                println(err)
                
            }else{
                
                //var responseStr:NSString = NSString(data:responseData!, encoding:NSUTF8StringEncoding)!
                
                var json : AnyObject? = NSJSONSerialization.JSONObjectWithData(responseData!, options: NSJSONReadingOptions.allZeros, error:nil)
                
                var state: NSNumber = json?.objectForKey("state") as! NSNumber
                
                //println(responseStr)
                
                if state == 3 {
                    
                    var alertController1 = UIAlertController(title: " name already exists！", message: nil, preferredStyle: .Alert)
                    
                    var cancelAction = UIAlertAction(title: "Retry", style: .Cancel, handler: nil)
                    
                    alertController1.addAction(cancelAction)
                    
                    self.presentViewController(alertController1, animated: true, completion: nil)
                    
                }
                    
                else{
                    
                    self.performSegueWithIdentifier("RegisterSegue", sender: self)
                    
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
    
    
    
    func checkName()->Bool{
        
        if Regisname.text=="" || Regispassword.text=="" {
            
            var alertController1 = UIAlertController(title: "Invaild Name or Password", message: nil, preferredStyle: .Alert)
            
            var cancelAction = UIAlertAction(title: "Retry", style: .Cancel, handler: nil)
            
            alertController1.addAction(cancelAction)
            
            self.presentViewController(alertController1, animated: true, completion: nil)
            
            return false
            
        }
        else if count(Regispassword.text) < 8 {
            var alertController1 = UIAlertController(title: "Password length must be longer than 8 characters", message: nil, preferredStyle: .Alert)
            
            var cancelAction = UIAlertAction(title: "Retry", style: .Cancel, handler: nil)
            
            alertController1.addAction(cancelAction)
            
            self.presentViewController(alertController1, animated: true, completion: nil)
            
            return false
        }
        return true        
    }
}

