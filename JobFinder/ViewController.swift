//
//  ViewController.swift
//  JobFinder
//
//  Created by 杨鹏 on 4/20/15.
//  Copyright (c) 2015 pengyang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(segue:UIStoryboardSegue){
        print("closed")
    }

}

