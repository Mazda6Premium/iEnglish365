//
//  AppRuleVC.swift
//  TrollVui
//
//  Created by Fighting on 9/29/19.
//  Copyright © 2019 Fighting. All rights reserved.
//

import UIKit

class AppRuleVC: UIViewController {
    
    @IBOutlet weak var tvRule: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        roundCorner(views: [tvRule], radius: 10)
    }
    
    @IBAction func tapOnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
