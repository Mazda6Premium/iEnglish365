//
//  SetPasswordVC.swift
//  TrollVui
//
//  Created by Nguyễn Thành Trung on 10/16/19.
//  Copyright © 2019 Fighting. All rights reserved.
//

import UIKit
import Firebase


class SetPasswordVC: UIViewController {
    
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirm: UITextField!
    @IBOutlet weak var btnNext: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        roundCorner(views: [btnNext], radius: 8)
        txtPassword.becomeFirstResponder()
    }
    
    @IBAction func tapOnNext(_ sender: Any) {
        self.view.endEditing(true)
        showLoading(viewCtrl: self)
        guard let phone = userDefaults.string(forKey: "userPhoneNumber") else {return}
        if txtPassword.text == "" || txtConfirm.text == "" {
            self.view.makeToast("Bạn phải nhập đủ các trường")
            hideLoading(viewCtrl: self)
        } else {
            if txtPassword.text!.count < 6 {
                self.view.makeToast("Mật khẩu phải có độ dài lớn hơn 6 ký tự")
                hideLoading(viewCtrl: self)
                return
            }
            
            if txtPassword.text != txtConfirm.text {
                self.view.makeToast("Xác nhận mật khẩu không trùng khớp")
                hideLoading(viewCtrl: self)
                return
            }
            
            let userForgetPassword = userDefaults.bool(forKey: "userForgetPassword")
            if userForgetPassword {
                let value = ["password": txtPassword.text!]
                databaseReference.child("UserPhone").child(phone).updateChildValues(value)
                hideLoading(viewCtrl: self)
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let naviEnterPassword = storyBoard.instantiateViewController(withIdentifier: "naviEnterPassword")
                naviEnterPassword.modalPresentationStyle = .fullScreen
                self.present(naviEnterPassword, animated: true, completion: nil)
                return
            }

            let value = ["password": txtPassword.text!]
            databaseReference.child("UserPhone").child(phone).updateChildValues(value)
            hideLoading(viewCtrl: self)
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let naviUserInfo = storyBoard.instantiateViewController(withIdentifier: "naviUserInfo")
            naviUserInfo.modalPresentationStyle = .fullScreen
            self.present(naviUserInfo, animated: true, completion: nil)
        }
    }
    
    @IBAction func tapOnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
