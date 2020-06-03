//
//  PersonalVC.swift
//  LearningLanguage
//
//  Created by Linh Nguyen on 2/26/20.
//  Copyright © 2020 NguyenQuocViet. All rights reserved.
//

import UIKit

class PersonalVC: UIViewController {

    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLevel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var lblLesson: UILabel!
    @IBOutlet weak var lblAchievement: UILabel!
    
    var fluent = 20
    var lesson = 200
    var achievement = 43
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
    }
    
    func setUpNavigationBar() {
        navigationItem.title = "Cá nhân"
        navigationController?.navigationBar.tintColor = .white
    
    }
    
    
    
    
}
