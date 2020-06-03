//
//  ViewDimVC.swift
//  LearningLanguage
//
//  Created by Linh Nguyen on 2/21/20.
//  Copyright © 2020 NguyenQuocViet. All rights reserved.
//

import UIKit

class ViewDimVC: UIViewController {
    
    @IBOutlet weak var viewChoose: UIView!
    @IBOutlet weak var viewOp1: UIView!
    @IBOutlet weak var viewOp2: UIView!
    @IBOutlet weak var viewOp3: UIView!
    @IBOutlet weak var imgOp1: UIImageView!
    @IBOutlet weak var imgOp2: UIImageView!
    @IBOutlet weak var imgOp3: UIImageView!
    @IBOutlet weak var lblOp1: UILabel!
    @IBOutlet weak var lblOp2: UILabel!
    @IBOutlet weak var lblOp3: UILabel!
    @IBOutlet weak var btnDIsmiss: UIButton!
    
    var imageTopic = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUpView()
        setUpGesture()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    func setUpView() {
        roundCorner(views: [viewChoose, viewOp1, viewOp2, viewOp3, btnDIsmiss], radius: 10)
        
        view.isOpaque = true
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        imgOp1.image = UIImage(named : "questionask")
        imgOp2.image = UIImage(named: "yesno")
        imgOp3.image = UIImage(named: "pair")
    }
    
    func setUpGesture() {
        
        let questionAskTap = UITapGestureRecognizer(target: self, action: #selector(presentSelectionVC))
        viewOp1.addGestureRecognizer(questionAskTap)
    }
    
    @objc func presentSelectionVC() {
        let selectionVC = SelectionVC(nibName: "SelectionVC", bundle: nil)
        selectionVC.modalTransitionStyle = .coverVertical
        selectionVC.modalPresentationStyle = .fullScreen
        self.present(selectionVC, animated: true, completion: nil)
    }
    
    @objc func presentPairVC() {
        let pairVC = PairVC(nibName: "PairVC", bundle: nil)
        pairVC.modalTransitionStyle = .coverVertical
        pairVC.modalPresentationStyle = .fullScreen
        self.present(pairVC, animated: true, completion: nil)
    }
    
    @IBAction func tapOnDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
