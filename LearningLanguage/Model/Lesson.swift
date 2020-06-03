//
//  Lesson.swift
//  LearningLanguage
//
//  Created by Linh Nguyen on 2/19/20.
//  Copyright © 2020 NguyenQuocViet. All rights reserved.
//

import Foundation

class Lesson {
    var title = ""
    
    init(dict :[String:Any]) {
        self.title = dict["title"] as? String ?? ""
    }
    
    
}
