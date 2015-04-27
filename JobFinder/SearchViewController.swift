//
//  SearchViewController.swift
//  JobFinder
//
//  Created by 杨鹏 on 4/20/15.
//  Copyright (c) 2015 pengyang. All rights reserved.
//


import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var JobSourceSelect: UISegmentedControl!
    
    @IBOutlet weak var JobOrderSelect: UISegmentedControl!
    
    @IBOutlet weak var JobKeyword: UITextField!
    
    @IBOutlet weak var JobLocation: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closed(segue:UIStoryboardSegue){
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SearchSegue"{
            let vc = segue.destinationViewController as! ListViewController
            if JobSourceSelect.selectedSegmentIndex == 0 {
                vc.sourcename = "careerbuilder"
            }
            else{
                vc.sourcename = "jobserve"
            }
            if JobOrderSelect.selectedSegmentIndex == 0{
                vc.listorder = "date"
            }
            else{
                vc.listorder = "Relevance"
            }
            if JobKeyword.text=="" || JobLocation.text=="" {
                
                var alertController1 = UIAlertController(title: "Invaild Keyword or Location", message: nil, preferredStyle: .Alert)
                
                var cancelAction = UIAlertAction(title: "Retry", style: .Cancel, handler: nil)
                
                alertController1.addAction(cancelAction)
                
                self.presentViewController(alertController1, animated: true, completion: nil)
            }
            else{
                
                vc.jobkeyword = JobKeyword.text
                vc.joblocation = JobLocation.text

                self.shouldPerformSegueWithIdentifier("SearchSegue", sender: self)
            }

                
        }
    }
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        JobKeyword.resignFirstResponder()
        JobLocation.resignFirstResponder()
    }

}
