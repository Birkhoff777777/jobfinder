//
//  ListViewController.swift
//  JobFinder
//
//  Created by 杨鹏 on 4/20/15.
//  Copyright (c) 2015 pengyang. All rights reserved.
//

import UIKit

class ListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var sourcename:String = ""
    var listorder:String = ""
    var joblocation:String = ""
    var jobkeyword:String = ""
    var lists : [ListModel] = []
    var JobNumber:Int?
    var pagenumber = 1 as Int    //store data
    
    @IBOutlet weak var PreButton: UIButton!
    
    @IBOutlet weak var JobsListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        PreButton.hidden = true
        JobsListTableView.editing = false
        let nsurl = NSURL(string: "https://jobfinder1.herokuapp.com/jobs")
        var request = NSMutableURLRequest(URL: nsurl!)
        
        request.HTTPMethod = "POST"
        
        let postData: AnyObject = ["keywords":jobkeyword,"sortBy":listorder,"pageNumber":1,"pageSize":15,"location":joblocation,"jobSource":sourcename]
        
        //let postString = "{name:test3,password:33333333}"
        let postString = JSONStringify(postData)
        //println(postString)
        
        let data = postString.dataUsingEncoding(NSUTF8StringEncoding)
        //println(data)
        
        request.HTTPBody = data
        //println(request)
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
            var jobcontent = resp["content"] as! NSDictionary
            var jobstate = resp["state"] as! NSNumber
            let jobtotalcount = jobcontent["totalCount"] as! NSInteger
            let joblist = jobcontent["jobs"] as! NSArray
            let jobfirstindex = jobcontent["firstItemIndex"] as! NSInteger
            let joblastindex = jobcontent["lastItemIndex"] as! NSInteger
            JobNumber = (joblastindex - jobfirstindex)+1
            for var index = 0; index < JobNumber; ++index{
                let jobentity = joblist[index] as! NSDictionary
                let jobtitle = jobentity["jobTitle"] as! NSString
                let jobcompany = jobentity["company"] as! NSString
                let jobid = jobentity["jobID"] as! NSString
                let joblocation = jobentity["location"] as! NSString
                let jobdate = jobentity["postDate"] as! NSString
                var modelexample : ListModel? = ListModel()
                modelexample?.company = jobcompany as String
                modelexample?.title = jobtitle as String
                modelexample?.id = jobid as String
                modelexample?.location = joblocation as String
                modelexample?.date = jobdate as String
                lists.append(modelexample!)
            }
//            println("~~~")
//            println(sourcename)
//            println(listorder)
//            println("~~~")
//
    }
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return JobNumber!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = self.JobsListTableView.dequeueReusableCellWithIdentifier("jobviewcell") as! UITableViewCell
        var joblistmodel : ListModel
        joblistmodel = lists[indexPath.row] as ListModel
        
        var titlename = cell.viewWithTag(101) as! UILabel
        var companyname = cell.viewWithTag(102) as! UILabel
        var locationname = cell.viewWithTag(103) as! UILabel
        var datename = cell.viewWithTag(104) as! UILabel
        
        companyname.text = joblistmodel.company
        titlename.text = joblistmodel.title
        locationname.text = joblistmodel.location
        datename.text = joblistmodel.date
        
        
        return cell
    }
    
    @IBAction func PreviousButton(sender: AnyObject) {
        if pagenumber == 2{
            PreButton.hidden = true
            --pagenumber
        }
        else{
            --pagenumber
        }
        lists.removeAll(keepCapacity: true)
        let nsurl = NSURL(string: "https://jobfinder1.herokuapp.com/jobs")
        var request = NSMutableURLRequest(URL: nsurl!)
        
        request.HTTPMethod = "POST"
        
        let postData: AnyObject = ["keywords":jobkeyword,"sortBy":listorder,"pageNumber":pagenumber,"pageSize":15,"location":joblocation,"jobSource":sourcename]
        
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
            var jobcontent = resp["content"] as! NSDictionary
            var jobstate = resp["state"] as! NSNumber
            let jobtotalcount = jobcontent["totalCount"] as! NSInteger
            let joblist = jobcontent["jobs"] as! NSArray
            let jobfirstindex = jobcontent["firstItemIndex"] as! NSInteger
            let joblastindex = jobcontent["lastItemIndex"] as! NSInteger
            JobNumber = (joblastindex - jobfirstindex)+1
            for var index = 0; index < JobNumber; ++index{
                let jobentity = joblist[index] as! NSDictionary
                let jobtitle = jobentity["jobTitle"] as! NSString
                let jobcompany = jobentity["company"] as! NSString
                let jobid = jobentity["jobID"] as! NSString
                let joblocation = jobentity["location"] as! NSString
                let jobdate = jobentity["postDate"] as! NSString
                var modelexample : ListModel? = ListModel()
                modelexample?.company = jobcompany as String
                modelexample?.title = jobtitle as String
                modelexample?.id = jobid as String
                modelexample?.location = joblocation as String
                modelexample?.date = jobdate as String
                lists.append(modelexample!)
            }
        }
        self.JobsListTableView.reloadData()
    }
    

    @IBAction func NextButton(sender: AnyObject) {
        // Do any additional setup after loading the view, typically from a nib.
        PreButton.hidden = false
        ++pagenumber
        lists.removeAll(keepCapacity: true)
        let nsurl = NSURL(string: "https://jobfinder1.herokuapp.com/jobs")
        var request = NSMutableURLRequest(URL: nsurl!)
        
        request.HTTPMethod = "POST"
        
        let postData: AnyObject = ["keywords":jobkeyword,"sortBy":listorder,"pageNumber":pagenumber,"pageSize":15,"location":joblocation,"jobSource":sourcename]
        
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
            var jobcontent = resp["content"] as! NSDictionary
            var jobstate = resp["state"] as! NSNumber
            let jobtotalcount = jobcontent["totalCount"] as! NSInteger
            let joblist = jobcontent["jobs"] as! NSArray
            let jobfirstindex = jobcontent["firstItemIndex"] as! NSInteger
            let joblastindex = jobcontent["lastItemIndex"] as! NSInteger
            JobNumber = (joblastindex - jobfirstindex)+1
            for var index = 0; index < JobNumber; ++index{
                let jobentity = joblist[index] as! NSDictionary
                let jobtitle = jobentity["jobTitle"] as! NSString
                let jobcompany = jobentity["company"] as! NSString
                let jobid = jobentity["jobID"] as! NSString
                let joblocation = jobentity["location"] as! NSString
                let jobdate = jobentity["postDate"] as! NSString
                var modelexample : ListModel? = ListModel()
                modelexample?.company = jobcompany as String
                modelexample?.title = jobtitle as String
                modelexample?.id = jobid as String
                modelexample?.location = joblocation as String
                modelexample?.date = jobdate as String
                lists.append(modelexample!)
            }
        }
        self.JobsListTableView.reloadData()
    }
    
    @IBAction func close(segue:UIStoryboardSegue){
        print("closed")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailSegue"{
            var index : NSIndexPath = JobsListTableView.indexPathForSelectedRow()!
            
            //println(index?.row)
            var temjobmodel = lists[index.row]
            var temjobid = temjobmodel.id
            var vc : DetailViewController = segue.destinationViewController as! DetailViewController
            vc.temjobnumber = temjobid
            vc.temsourcename = sourcename
        }
    }
    
}


