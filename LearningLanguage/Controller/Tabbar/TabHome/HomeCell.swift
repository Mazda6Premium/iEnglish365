//
//  HomeCell.swift
//  LearningLanguage
//
//  Created by Linh Nguyen on 2/19/20.
//  Copyright © 2020 NguyenQuocViet. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var imgTopic: UIImageView!
    @IBOutlet weak var lblTopic: UILabel!
    @IBOutlet weak var viewImgTopic: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setUpView()
    }

    func setUpView() {
        
        roundCorner(views: [viewImgTopic], radius: 25)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }

}
