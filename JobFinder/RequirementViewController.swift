//
//  RequirementViewController.swift
//  JobFinder
//
//  Created by 杨鹏 on 4/26/15.
//  Copyright (c) 2015 pengyang. All rights reserved.
//

import UIKit

class RequirementViewController: UIViewController {
    
    var requirementdata : NSData?
    
    @IBOutlet weak var RequirementDetailView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        RequirementDetailView.loadData(requirementdata,MIMEType: "text/html", textEncodingName: "utf-8", baseURL: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
