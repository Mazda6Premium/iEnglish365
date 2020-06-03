//
//  PushLessonVC.swift
//  LearningLanguage
//
//  Created by Linh Nguyen on 3/14/20.
//  Copyright © 2020 NguyenQuocViet. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import Toast_Swift

class PushLessonVC: UIViewController {
    
    @IBOutlet weak var txtChuDe: UITextField!
    @IBOutlet weak var txtTenBai: UITextField!
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var txtEnglish1: UITextField!
    @IBOutlet weak var txtVietnamese1: UITextField!
    
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var txtEnglish2: UITextField!
    @IBOutlet weak var txtVietnamese2: UITextField!
    
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var txtEnglish3: UITextField!
    @IBOutlet weak var txtVietnamese3: UITextField!
    
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var txtEnglish4: UITextField!
    @IBOutlet weak var txtVietnamese4: UITextField!
    
    @IBOutlet weak var img5: UIImageView!
    @IBOutlet weak var txtEnglish5: UITextField!
    @IBOutlet weak var txtVietnamese5: UITextField!
    
    @IBOutlet weak var img6: UIImageView!
    @IBOutlet weak var txtEnglish6: UITextField!
    @IBOutlet weak var txtVietnamese6: UITextField!
    
    @IBOutlet weak var img7: UIImageView!
    @IBOutlet weak var txtEnglish7: UITextField!
    @IBOutlet weak var txtVietnamese7: UITextField!
    
    @IBOutlet weak var btnDang: UIButton!
    
    var arrayEnglish = [UITextField]()
    var arrayVietnamese = [UITextField]()
    var arrayImage = [UIImageView]()
    
    var chooseImage1 : UIImage?
    var chooseImage2 : UIImage?
    var chooseImage3 : UIImage?
    var chooseImage4 : UIImage?
    var chooseImage5 : UIImage?
    var chooseImage6 : UIImage?
    var chooseImage7 : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        arrayEnglish = [txtEnglish1, txtEnglish2, txtEnglish3, txtEnglish4, txtEnglish5, txtEnglish6, txtEnglish7 ]
        arrayVietnamese = [txtVietnamese1, txtVietnamese2, txtVietnamese3, txtVietnamese4, txtVietnamese5, txtVietnamese6, txtVietnamese7]
        arrayImage = [img1, img2, img3, img4, img5, img6, img7]
        
        txtChuDe.delegate = self
        setUpView()
//        setUpGesture()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setUpView() {
        roundCorner(views: arrayImage, radius: 10)
        addBorder(views: arrayImage, width: 1, color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        
    }
    
    @IBAction func tapOnPush(_ sender: Any) {
        showLoading(viewCtrl: self)
        self.view.endEditing(true)
        
        if txtChuDe.text == "" {
            self.view.makeToast("Chưa chọn chủ đề")
            hideLoading(viewCtrl: self)
            return
        }
        
        if txtTenBai.text == "" {
            self.view.makeToast("Chưa nhập tên bài")
            hideLoading(viewCtrl: self)
            return
        }
        
        if  txtEnglish1.text == "" ||
            txtEnglish2.text == "" ||
            txtEnglish3.text == "" ||
            txtEnglish4.text == "" ||
            txtEnglish5.text == "" ||
            txtEnglish6.text == "" ||
            txtEnglish7.text == "" {
            self.view.makeToast("Chưa nhập từ gốc")
            hideLoading(viewCtrl: self)
            return
        }
        
        if  txtVietnamese1.text == "" ||
            txtVietnamese2.text == "" ||
            txtVietnamese3.text == "" ||
            txtVietnamese4.text == "" ||
            txtVietnamese5.text == "" ||
            txtVietnamese6.text == "" ||
            txtVietnamese7.text == "" {
            self.view.makeToast("Chưa nhập nghĩa")
            hideLoading(viewCtrl: self)
            return
        }
        
        
        pushData()
    }
    
    func pushData() {
        guard let chuDe = txtChuDe.text else {return}
        guard let tenBai = txtTenBai.text else {return}
        
        guard let tiengAnh1 = txtEnglish1.text else {return}
        guard let tiengAnh2 = txtEnglish2.text else {return}
        guard let tiengAnh3 = txtEnglish3.text else {return}
        guard let tiengAnh4 = txtEnglish4.text else {return}
        guard let tiengAnh5 = txtEnglish5.text else {return}
        guard let tiengAnh6 = txtEnglish6.text else {return}
        guard let tiengAnh7 = txtEnglish7.text else {return}
        
        guard let tiengViet1 = txtVietnamese1.text else {return}
        guard let tiengViet2 = txtVietnamese2.text else {return}
        guard let tiengViet3 = txtVietnamese3.text else {return}
        guard let tiengViet4 = txtVietnamese4.text else {return}
        guard let tiengViet5 = txtVietnamese5.text else {return}
        guard let tiengViet6 = txtVietnamese6.text else {return}
        guard let tiengViet7 = txtVietnamese7.text else {return}
                
        let value = [
            "tiengAnh1" : tiengAnh1, "tiengViet1" : tiengViet1,
            "tiengAnh2" : tiengAnh2, "tiengViet2" : tiengViet2,
            "tiengAnh3" : tiengAnh3, "tiengViet3" : tiengViet3,
            "tiengAnh4" : tiengAnh4, "tiengViet4" : tiengViet4,
            "tiengAnh5" : tiengAnh5, "tiengViet5" : tiengViet5,
            "tiengAnh6" : tiengAnh6, "tiengViet6" : tiengViet6,
            "tiengAnh7" : tiengAnh7, "tiengViet7" : tiengViet7
            ] as [String : Any]
        databaseReference.child("Data").child(chuDe).child(tenBai).setValue(value)
        showSuccess(viewCtrl: self)
        _ = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.clearData), userInfo: nil, repeats: true)
    }
    
    @objc func clearData() {
        hideLoading(viewCtrl: self)
        
        arrayVietnamese.forEach { (vietnamese) in
            vietnamese.text = ""
        }
        
        arrayEnglish.forEach { (english) in
            english.text = ""
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension PushLessonVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.view.endEditing(true)
        ActionSheetStringPicker.show(withTitle: "Chọn chủ đề ", rows: ["Animal", "Clothes", "Food","Job","Vehicle","Sport","Tool", "Kitchen", "Stationery"], initialSelection: 0, doneBlock: { (picker, index, value) in
            if let chuDe = value as? String {
                self.txtChuDe.text = chuDe
            }
        }, cancel: { (picker) in
            return
        }, origin: txtChuDe)
        
    }
}
