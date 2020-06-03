//
//  LessonDetail.swift
//  LearningLanguage
//
//  Created by Linh Nguyen on 3/19/20.
//  Copyright © 2020 NguyenQuocViet. All rights reserved.
//

import Foundation

class LessonDetail {
    var vietnamese1 = ""
    var vietnamese2 = ""
    var vietnamese3 = ""
    var vietnamese4 = ""
    var vietnamese5 = ""
    var vietnamese6 = ""
    var vietnamese7 = ""
    
    var english1 = ""
    var english2 = ""
    var english3 = ""
    var english4 = ""
    var english5 = ""
    var english6 = ""
    var english7 = ""
    
//    var image1 = ""
//    var image2 = ""
//    var image3 = ""
//    var image4 = ""
//    var image5 = ""
//    var image6 = ""
//    var image7 = ""

    init(dict: [String: Any]) {
        self.vietnamese1 = dict["tiengViet1"] as? String ?? ""
        self.vietnamese2 = dict["tiengViet2"] as? String ?? ""
        self.vietnamese3 = dict["tiengViet3"] as? String ?? ""
        self.vietnamese4 = dict["tiengViet4"] as? String ?? ""
        self.vietnamese5 = dict["tiengViet5"] as? String ?? ""
        self.vietnamese6 = dict["tiengViet6"] as? String ?? ""
        self.vietnamese7 = dict["tiengViet7"] as? String ?? ""
        self.english1 = dict["tiengAnh1"] as? String ?? ""
        self.english2 = dict["tiengAnh2"] as? String ?? ""
        self.english3 = dict["tiengAnh3"] as? String ?? ""
        self.english4 = dict["tiengAnh4"] as? String ?? ""
        self.english5 = dict["tiengAnh5"] as? String ?? ""
        self.english6 = dict["tiengAnh6"] as? String ?? ""
        self.english7 = dict["tiengAnh7"] as? String ?? ""
//        self.image1 = dict["image1"] as? String ?? ""
//        self.image2 = dict["image2"] as? String ?? ""
//        self.image3 = dict["image3"] as? String ?? ""
//        self.image4 = dict["image4"] as? String ?? ""
//        self.image5 = dict["image5"] as? String ?? ""
//        self.image6 = dict["image6"] as? String ?? ""
//        self.image7 = dict["image7"] as? String ?? ""
    }
}
