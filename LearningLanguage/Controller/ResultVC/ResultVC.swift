//
//  ResultVC.swift
//  LearningLanguage
//
//  Created by Linh Nguyen on 2/20/20.
//  Copyright © 2020 NguyenQuocViet. All rights reserved.
//

import UIKit

class ResultVC: UIViewController {
    
    @IBOutlet weak var imgTopic: UIImageView!
    @IBOutlet weak var imgCompleted: UIImageView!
    @IBOutlet weak var lblResult: UILabel!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var viewTopic: UIView!
    
    var imageTopic = ""
    var result : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUpView()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
    
    func setUpView() {
        
        roundCorner(views: [btnDone], radius: 10)
        roundCorner(views: [imgCompleted], radius: 30)
        roundCorner(views: [viewTopic], radius: 70)
        addBorder(views: [viewTopic], width: 5, color: UIColor.white.cgColor)
        
        imgTopic.image = UIImage(named: imageTopic)
        viewTopic.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        
        
        lblResult.text = "Bạn đã hoàn thành"
        imgCompleted.image = UIImage(named: "pass")
        }
        
    
    @IBAction func tapOnDone(_ sender: Any) {
        if let destinationVC = navigationController?.viewControllers
            .filter (
                {$0.classForCoder == LessonVC.self} )
            .first {
            navigationController?.popToViewController(destinationVC, animated: true)
        }
        
    }
    
    
}
