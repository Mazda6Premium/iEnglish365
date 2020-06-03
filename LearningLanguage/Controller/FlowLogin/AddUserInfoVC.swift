//
//  AddUserInfoVC.swift
//  TrollVui
//
//  Created by Fighting on 8/22/19.
//  Copyright © 2019 Fighting. All rights reserved.
//

import UIKit
import Firebase
import Toast_Swift
import ActionSheetPicker_3_0

class AddUserInfoVC: UIViewController {
    
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var txtBirthday: UITextField!
    
    var avatar: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtGender.delegate = self
        txtBirthday.delegate = self

        // Do any additional setup after loading the view.
        addBorder(views: [imgAvatar], width: 1, color: #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1))
        roundCorner(views: [imgAvatar], radius: 40)
        roundCorner(views: [btnDone], radius: 8)
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imgAvatar.isUserInteractionEnabled = true
        imgAvatar.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func tapOnDone(_ sender: Any) {
        if txtUsername.text == "" {
            self.view.makeToast("Vui lòng nhập tên hiển thị")
        } else {
            postUserData()
        }
    }
    
    func postUserData() {
        guard let user = Auth.auth().currentUser else {return}
        guard let name = txtUsername.text else {return}
        let phone = user.phoneNumber?.replacingOccurrences(of: "+84", with: "0")
        
        if avatar == nil {
            let value = ["phone": phone as Any, "name": name, "id": user.uid, "gender": txtGender.text as Any, "birthday": txtBirthday.text as Any] as [String : Any]
            databaseReference.child("Users").child(user.uid).setValue(value)
            let storyBoard = UIStoryboard(name: "Tabbar", bundle: nil)
            let tabBarVC = storyBoard.instantiateViewController(withIdentifier: "tabbar")
            tabBarVC.modalPresentationStyle = .fullScreen
            self.present(tabBarVC, animated: true, completion: nil)
        } else {
            guard let image = avatar, let data = image.jpegData(compressionQuality: 0.1) else {return}
            let imageStorage = storageReference.child("Avatar").child(user.uid)
            imageStorage.putData(data, metadata: nil) { (metadata, error) in
                if error != nil {
                    self.view.makeToast("Có lỗi xảy ra")
                    return
                }
                imageStorage.downloadURL(completion: { (url, error) in
                    guard let avatarUrl = url else {return}
                    let value = ["phone": phone as Any, "name": name, "id": user.uid, "avatarUrl": "\(String(describing: avatarUrl))", "gender": self.txtGender.text as Any, "birthday": self.txtBirthday.text as Any] as [String : Any]
                    databaseReference.child("Users").child(user.uid).setValue(value)
                    let storyBoard = UIStoryboard(name: "Tabbar", bundle: nil)
                    let tabBarVC = storyBoard.instantiateViewController(withIdentifier: "tabbar")
                    tabBarVC.modalPresentationStyle = .fullScreen
                    self.present(tabBarVC, animated: true, completion: nil)
                })
            }
        }
    }
    
    @objc func chooseImage() {
        let photoLibraryAction = UIAlertAction(title: NSLocalizedString("Thư viện Ảnh", comment: ""), style: .default, handler: { _ in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        })
        
        let takePhotoAction = UIAlertAction(title: NSLocalizedString("Chụp ảnh", comment: ""), style: .default, handler: { _ in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera;
            self.present(imagePicker, animated: true, completion: nil)
        })
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Huỷ", comment: ""), style: .cancel, handler: { _ in
        })
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(takePhotoAction)
        actionSheet.addAction(photoLibraryAction)
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true) { () -> Void in
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension AddUserInfoVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        avatar = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        imgAvatar.image = avatar
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension AddUserInfoVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case txtGender:
            self.view.endEditing(true)
            ActionSheetStringPicker.show(withTitle: "Chọn giới tính", rows: ["Nam", "Nữ"], initialSelection: 0, doneBlock: { (picker, index, value) in
                if let gender = value as? String {
                    self.txtGender.text = gender
                }
            }, cancel: { (picker) in
                return
            }, origin: txtGender)
            
        case txtBirthday:
            self.view.endEditing(true)
            let date = Date()
            let datePicker = ActionSheetDatePicker(title: "Chọn ngày sinh", datePickerMode: .date, selectedDate: date, doneBlock: { picker, value, origin in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                if let date = value as? Date {
                    let dateString = dateFormatter.string(from: date)
                    self.txtBirthday.text = dateString
                }
            },cancel: { picker in
                return
            }, origin: txtBirthday)
            datePicker?.maximumDate = date
            datePicker?.show()
        default:
            break
        }
    }
}

