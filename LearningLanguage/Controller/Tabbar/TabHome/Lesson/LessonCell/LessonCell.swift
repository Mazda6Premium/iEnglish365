//
//  LessonCell.swift
//  LearningLanguage
//
//  Created by Linh Nguyen on 2/19/20.
//  Copyright © 2020 NguyenQuocViet. All rights reserved.
//

import UIKit

class LessonCell: UITableViewCell {

    @IBOutlet weak var lessonTitle: UILabel!
    @IBOutlet weak var imgLesson: UIImageView!
    @IBOutlet weak var viewImg: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        roundCorner(views: [viewImg], radius: 25)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
