//
//  UserPhone.swift
//  TrollVui
//
//  Created by Nguyễn Thành Trung on 10/16/19.
//  Copyright © 2019 Fighting. All rights reserved.
//

import Foundation

class UserPhone {
    var phone = ""
    var password = ""
    var id = ""
    
    init(dict: [String: Any]) {
        self.phone = dict["phone"] as? String ?? ""
        self.password = dict["password"] as? String ?? ""
        self.id = dict["id"] as? String ?? ""
    }
}
