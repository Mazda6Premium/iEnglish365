
import Foundation

class Topic {
    
    var imgTopic = ""
    var lblTopic = ""
    
//    init(dict : [String:Any]) {
//        self.imgTopic = dict["imgTopic"] as? String ?? ""
//        self.lblTopic = dict["lblTopic"] as? String ?? ""
//    }
    
    init(imgTopic : String, lblTopic : String) {
        self.imgTopic = imgTopic
        self.lblTopic = lblTopic
    }
}
