//
//  DetailViewController.swift
//  JobFinder
//
//  Created by Ke Wang on 4/25/15.
//  Copyright (c) 2015 pengyang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    


    @IBOutlet weak var JobTitle: UILabel!
    
    @IBOutlet weak var JobCompany: UILabel!
    
    @IBOutlet weak var JobContractPhone: UILabel!
    
    @IBOutlet weak var JobType: UILabel!
    
    @IBOutlet weak var DetailWebViewList: UIWebView!
    
    
    
    var temsourcename : String = ""
    var temjobnumber:String = ""
    var temrequirementdata: NSData?
    var temjoblink :String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        println("!!!!!!")
//        println(temjobnumber)
//        println(temsourcename)
//        println("!!!!!!")
        
        let nsurl = NSURL(string: "https://jobfinder1.herokuapp.com/job")
        var request = NSMutableURLRequest(URL: nsurl!)
        
        request.HTTPMethod = "POST"
        
        let postData: AnyObject = ["jobID":temjobnumber,"jobSource":temsourcename]
        
        //let postString = "{name:test3,password:33333333}"
        let postString = JSONStringify(postData)
        
        
        let data = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        request.HTTPBody = data
        var response:AutoreleasingUnsafeMutablePointer<NSURLResponse?> = nil
        var err:NSErrorPointer = nil
        var responseData = NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error: err)
        if err != nil{
            println(err)
        }else{
            var parseError: NSError?
            let parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(responseData!,
                options: NSJSONReadingOptions.AllowFragments,
                error:&parseError)
            
            var resp = parsedObject as! NSDictionary
            var currjobcontent = resp["content"] as! NSDictionary
            var currjobstate = resp["state"] as! NSNumber
            let currjobcompany = currjobcontent["company"] as! NSString
            let currjobtitle = currjobcontent["jobTitle"] as! NSString
            let currjobtype = currjobcontent["jobType"] as! NSString
            let currjobcontactPhone = currjobcontent["contactPhone"] as! NSString
            
            var currjobdetaildescription = currjobcontent["jobDescription"] as! String
            currjobdetaildescription = "<html><body>\(currjobdetaildescription)</body></html>"
            
            var currjobdetailrequirement = currjobcontent["jobRequirements"] as! String
            currjobdetailrequirement = "<html><body>\(currjobdetailrequirement)</body></html>"
           
            let currjoburlink = currjobcontent["urlLink"] as! NSString
            
            
            
            JobTitle.text = currjobtitle as String
            JobCompany.text = currjobcompany as String
            JobContractPhone.text = currjobcontactPhone as String
            JobType.text = currjobtype as String
            temjoblink = currjoburlink as String
            
            var data:NSData = NSData(bytes: currjobdetaildescription, length: count(currjobdetaildescription))
            DetailWebViewList.loadData(data, MIMEType: "text/html", textEncodingName: "utf-8", baseURL: nil)
            
            var requirementdata:NSData = NSData(bytes: currjobdetailrequirement, length: count(currjobdetailrequirement))
            temrequirementdata = requirementdata

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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closedd(segue:UIStoryboardSegue){
        
    }
    
    @IBAction func ApplyButton(sender: AnyObject) {
        
        self.openUrl(temjoblink);
    }
    
    func openUrl(url:String){
        let targetURL = NSURL(string: url)
        let application = UIApplication.sharedApplication()
        application.openURL(targetURL!)
    }
//    func openUrl(url:String!) {
//        
////        let targetURL=NSURL(string: url)
////        let application=UIApplication.sharedApplication()
////        application.openURL(targetURL!)
//     }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ClicktoSeeSegue"{
            var vc = segue.destinationViewController as! RequirementViewController
            vc.requirementdata = temrequirementdata
        }
    }
    
}

