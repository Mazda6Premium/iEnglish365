//
//  ViewController.swift
//  TrollVui
//
//  Created by Fighting on 8/20/19.
//  Copyright © 2019 Fighting. All rights reserved.
//

import UIKit
import Firebase
import Toast_Swift

class ViewController: UIViewController {

    @IBOutlet weak var imgLogIn: UIImageView!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var lblOr: UILabel!
    @IBOutlet weak var lblAppRules: UILabel!
    
    @IBOutlet weak var viewDim: UIView!
    @IBOutlet weak var viewAlert: UIView!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    
    @IBOutlet weak var btnLogIn: UIButton!
    @IBAction func tapOnLogIn(_ sender: Any) {
        self.view.endEditing(true)
        if txtPhoneNumber.text == "" {
            self.view.makeToast("Bạn chưa nhập số điện thoại")
            return
        }
        
        if !(txtPhoneNumber.text?.hasPrefix("0"))! || txtPhoneNumber.text!.count > 10 {
            self.view.makeToast("Số điện thoại không đúng định dạng")
            return
        }
        
        viewDim.isHidden = false
        viewAlert.isHidden = false
    }
    
    @IBOutlet weak var btnPlay: UIButton!
    @IBAction func tapOnPlay(_ sender: Any) {
        userDefaults.removeObject(forKey: "currentUserLoginId")
        userDefaults.synchronize()
        let storyBoard = UIStoryboard(name: "Tabbar", bundle: nil)
        let tabBarVC = storyBoard.instantiateViewController(withIdentifier: "tabbar")
        tabBarVC.modalPresentationStyle = .fullScreen
        self.present(tabBarVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        // auto login
        let id = userDefaults.string(forKey: "userAlreadyLogin")
        if id != nil {
            let storyBoard = UIStoryboard(name: "Tabbar", bundle: nil)
            let tabBarVC = storyBoard.instantiateViewController(withIdentifier: "tabbar")
            tabBarVC.modalPresentationStyle = .fullScreen
            self.present(tabBarVC, animated: false, completion: nil)
        }
    }
    
    func setupView() {
        viewDim.isHidden = true
        viewAlert.isHidden = true
        roundCorner(views: [btnLogIn], radius: 8)
        roundCorner(views: [btnPlay], radius: 8)
        roundCorner(views: [lblOr], radius: 17.5)
        roundCorner(views: [viewAlert], radius: 10)
        roundCorner(views: [btnYes], radius: 8)
        roundCorner(views: [btnNo], radius: 8)
        setupAppRule()
//        imgLogIn.startRotating(duration: 6, clockwise: true)
    }
    
    func setupAppRule() {
        // Terms & Use        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(moveToRule))
        lblAppRules.addGestureRecognizer(tapGesture)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func moveToRule() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let naviAppRule = storyBoard.instantiateViewController(withIdentifier: "naviAppRule")
        naviAppRule.modalPresentationStyle = .fullScreen
        self.present(naviAppRule, animated: true, completion: nil)
    }
    
    @IBAction func tapOnYes(_ sender: Any) {
        viewDim.isHidden = true
        viewAlert.isHidden = true
        showLoading(viewCtrl: self)
        guard let phone = txtPhoneNumber.text else {return}
        userDefaults.set(phone, forKey: "userPhoneNumber")
        userDefaults.synchronize()
        var isUserExist = false
        
        databaseReference.child("UserPhone").child(phone).observe(.value) { (data) in
            if data.exists() {
                isUserExist = true
                // SHOW PASSWORD -> LOGIN
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let enterPasswordVC = storyBoard.instantiateViewController(withIdentifier: "naviEnterPassword")
                enterPasswordVC.modalPresentationStyle = .fullScreen
                self.present(enterPasswordVC, animated: true, completion: nil)
                hideLoading(viewCtrl: self)
            }
            
            // SHOW OTP -> SET PASSWORD -> ADD USERINFO -> LOGIN
            if !isUserExist {
                // SAVE IN FIREBASE
                let value = ["phone": phone]
                databaseReference.child("UserPhone").child(phone).setValue(value)
                
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let otpVC = storyBoard.instantiateViewController(withIdentifier: "naviOTP")
                otpVC.modalPresentationStyle = .fullScreen
                self.present(otpVC, animated: true, completion: nil)
                hideLoading(viewCtrl: self)
            }
        }
    }
    
    @IBAction func tapOnNo(_ sender: Any) {
        viewDim.isHidden = true
        viewAlert.isHidden = true
    }
}

