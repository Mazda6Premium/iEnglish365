//
//  OTPViewController.swift
//  TrollVui
//
//  Created by Fighting on 8/21/19.
//  Copyright © 2019 Fighting. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Toast_Swift

class OTPViewController: UIViewController {
    
    @IBOutlet weak var txtOTPCode: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnResendOTP: UIButton!
    
    var second = 60
    var timer = Timer()
    var verificationId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        roundCorner(views: [btnNext], radius: 8)
        txtOTPCode.becomeFirstResponder()
        // Do any additional setup after loading the view.
        guard let userPhone = userDefaults.string(forKey: "userPhoneNumber") else {return}
        loginWithPhoneNumber(phone: userPhone)
    }
    
    func loginWithPhoneNumber(phone: String) {
        let rightFormatPhone = "+84\(phone)"
        print(rightFormatPhone)
        PhoneAuthProvider.provider().verifyPhoneNumber(rightFormatPhone, uiDelegate: nil) { (verificationID, error) in
            if error == nil {
                print("firebase registration \(String(describing: verificationID))")
                if let id = verificationID {
                    self.verificationId = id
                }
            } else {
                self.view.makeToast(error?.localizedDescription)
            }
        }
    }
    
    @IBAction func tapOnNext(_ sender: Any) {
        self.view.endEditing(true)
        // enter otp
        DispatchQueue.main.async {
            showLoading(viewCtrl: self)
        }
        guard let verificationCode = self.txtOTPCode.text else {
            hideLoading(viewCtrl: self)
            self.view.makeToast("Bạn chưa nhập mã OTP")
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue")
            guard let phone = userDefaults.string(forKey: "userPhoneNumber") else {return}
            // SHOW SETPASSWORD -> LOGIN
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.verificationId, verificationCode: verificationCode)
            
            Auth.auth().signIn(with: credential) { (user, error) in
                // TODO: handle sign in
                if error != nil {
                    self.view.makeToast("Sai mã OTP")
                    DispatchQueue.main.async {
                        hideLoading(viewCtrl: self)
                    }
                } else {
                    guard let id = user?.user.uid else {return}
                    userDefaults.set(id, forKey: "userAlreadyLogin")
                    userDefaults.set(id, forKey: "currentUserLoginId")
                    userDefaults.synchronize()
                    DispatchQueue.main.async {
                        hideLoading(viewCtrl: self)
                    }
                    let value = ["id": id]
                    databaseReference.child("UserPhone").child(phone).updateChildValues(value)
                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                    let setPasswordVC = storyBoard.instantiateViewController(withIdentifier: "naviSetPassword")
                    setPasswordVC.modalPresentationStyle = .fullScreen
                    self.present(setPasswordVC, animated: true, completion: nil)
                }
            }
            DispatchQueue.main.async {
                print("This is run on the main queue, after the previous code in outer block")
                hideLoading(viewCtrl: self)
            }
        }
        

    }
    
    @IBAction func tapOnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapOnResendOTP(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(sendOTPAgain), userInfo: nil, repeats: true)
    }
    
    @objc func sendOTPAgain() {
        second -= 1
        if second == 0 {
            guard let userPhone = userDefaults.string(forKey: "userPhoneNumber") else {return}
            loginWithPhoneNumber(phone: userPhone)
            btnResendOTP.setTitle("Gửi lại OTP", for: .normal)
            timer.invalidate()
            second = 60
        } else {
            btnResendOTP.setTitle("Nhận OTP sau \(second) giây", for: .normal)
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
