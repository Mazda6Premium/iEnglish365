//
//  EnterPasswordVC.swift
//  TrollVui
//
//  Created by Nguyễn Thành Trung on 10/16/19.
//  Copyright © 2019 Fighting. All rights reserved.
//

import UIKit
import Firebase

class EnterPasswordVC: UIViewController {
    
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnForget: UIButton!
    @IBOutlet weak var btnNext: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        roundCorner(views: [btnNext], radius: 8)
        txtPassword.becomeFirstResponder()
    }
    
    @IBAction func tapOnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapOnForget(_ sender: Any) {
        userDefaults.set(true, forKey: "userForgetPassword")
        userDefaults.synchronize()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let otpVC = storyBoard.instantiateViewController(withIdentifier: "naviOTP")
        otpVC.modalPresentationStyle = .fullScreen
        self.present(otpVC, animated: true, completion: nil)
    }
    
    @IBAction func tapOnLogin(_ sender: Any) {
        self.view.endEditing(true)
        showLoading(viewCtrl: self)
        guard let phone = userDefaults.string(forKey: "userPhoneNumber") else {return}
        guard let password = txtPassword.text else {
            self.view.makeToast("Vui lòng nhập mật khẩu")
            return
        }
        
        databaseReference.child("UserPhone").child(phone).observe(.value) { (snapshot) in
            if let dict = snapshot.value as? [String: Any] {
                let userPhone = UserPhone(dict: dict)
                userDefaults.set(userPhone.id, forKey: "currentUserLoginId")
                userDefaults.set(userPhone.id, forKey: "userAlreadyLogin")
                userDefaults.synchronize()
                if password == userPhone.password {
                    let storyBoard = UIStoryboard(name: "Tabbar", bundle: nil)
                    let tabBarVC = storyBoard.instantiateViewController(withIdentifier: "tabbar")
                    tabBarVC.modalPresentationStyle = .fullScreen
                    self.present(tabBarVC, animated: false, completion: nil)
                    hideLoading(viewCtrl: self)
                } else {
                    hideLoading(viewCtrl: self)
                    self.view.makeToast("Mật khẩu không chính xác")
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
