//
//  User.swift
//  iEnglish
//
//  Created by Nguyễn Thành Trung on 10/8/19.
//  Copyright © 2019 Fighting. All rights reserved.
//

import Foundation

class User {
    var birthday = ""
    var gender = ""
    var id = ""
    var name = ""
    var phone = ""
    var avatarUrl = ""
    
    init(dict: [String: Any]) {
        self.birthday = dict["birthday"] as? String ?? ""
        self.gender = dict["gender"] as? String ?? ""
        self.id = dict["id"] as? String ?? ""
        self.name = dict["name"] as? String ?? ""
        self.phone = dict["phone"] as? String ?? ""
        self.avatarUrl = dict["avatarUrl"] as? String ?? ""
    }
}
