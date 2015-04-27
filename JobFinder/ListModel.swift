//
//  ListModel.swift
//  JobFinder
//
//  Created by 杨鹏 on 4/24/15.
//  Copyright (c) 2015 pengyang. All rights reserved.
//

import UIKit

class ListModel: NSObject {
    var company:String
    var title:String
    var location:String
    var date:String
    var id:String
    init(company:String, title:String,location:String,
        date:String,id:String) {
        self.company = company
        self.title = title
        self.location = location
        self.date = date
        self.id = id
    }
    override init() {
            self.company = ""
            self.title = ""
            self.location = ""
            self.date = ""
            self.id = ""
    }
    
}
