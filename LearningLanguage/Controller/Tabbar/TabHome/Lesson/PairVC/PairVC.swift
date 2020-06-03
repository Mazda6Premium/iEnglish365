//
//  PairVC.swift
//  LearningLanguage
//
//  Created by Linh Nguyen on 2/18/20.
//  Copyright © 2020 NguyenQuocViet. All rights reserved.
//

import UIKit
import Toast_Swift
import Firebase

class PairVC: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    @IBOutlet weak var view7: UIView!
    @IBOutlet weak var view8: UIView!
    @IBOutlet weak var view9: UIView!
    @IBOutlet weak var view10: UIView!
    @IBOutlet weak var view11: UIView!
    @IBOutlet weak var view12: UIView!
    @IBOutlet weak var view13: UIView!
    @IBOutlet weak var view14: UIView!
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var lbl5: UILabel!
    @IBOutlet weak var lbl6: UILabel!
    @IBOutlet weak var lbl7: UILabel!
    @IBOutlet weak var lbl8: UILabel!
    @IBOutlet weak var lbl9: UILabel!
    @IBOutlet weak var lbl10: UILabel!
    @IBOutlet weak var lbl11: UILabel!
    @IBOutlet weak var lbl12: UILabel!
    @IBOutlet weak var lbl13: UILabel!
    @IBOutlet weak var lbl14: UILabel!
    
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var viewPopUp: UIView!
    @IBOutlet weak var viewHuongDan: UIView!
    @IBOutlet weak var btnDismiss: UIButton!
    
    var vietnamese = ""
    var english = ""
    var vietnameseView : [UIView]!
    var vietnameseLabel : [UILabel]!
    var englishView : [UIView]!
    var englishLabel : [UILabel]!
    var viewChoose1 : UIView!
    var viewChoose2 : UIView!
    var lblChoose1 : UILabel!
    var lblChoose2 : UILabel!
    var arrayVietnamese = [String]()
    var arrayEnglish = [String]()
    var arrayVietnameseShuffle = [String]()
    var arrayEnglishShuffle = [String]()
    var index1 = -1
    var index2 = -1
    var imageTopic = ""
    var numberPaired = 0
    var lesson = ""
    var topic = ""
    var arrayLessonDetail = [LessonDetail]()
    var progressValue : Float = 1/7
    var number = 1
    
    var style = ToastStyle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        vietnameseView = [view1, view2, view3, view4, view5, view6, view7]
        vietnameseLabel = [lbl1, lbl2, lbl3, lbl4, lbl5, lbl6, lbl7]
        
        englishView = [view8, view9, view10, view11, view11, view12, view13, view14]
        englishLabel = [lbl8, lbl9, lbl10, lbl11, lbl12, lbl13, lbl14]
        
        getDataFromFirebase()
        setUpView()
        setUpGesture()
        setUpNavigationBar()
        print(lesson)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    func getDataFromFirebase() {
        showLoading(viewCtrl: self)
        databaseReference.child("Data").child(topic).observeSingleEvent(of: .childAdded) { (data) in
            databaseReference.child("Data").child(self.topic).child(self.lesson).observeSingleEvent(of: .value) { (snap) in
                if let dict = snap.value as? [String: Any] {
                    let detail = LessonDetail(dict: dict)
                    self.arrayLessonDetail.append(detail)
                    self.loadData()
                    hideLoading(viewCtrl: self)
                }
            }
        }
    }
    
    func loadData() {
        
        arrayVietnamese.append(arrayLessonDetail[0].vietnamese1)
        arrayVietnamese.append(arrayLessonDetail[0].vietnamese2)
        arrayVietnamese.append(arrayLessonDetail[0].vietnamese3)
        arrayVietnamese.append(arrayLessonDetail[0].vietnamese4)
        arrayVietnamese.append(arrayLessonDetail[0].vietnamese5)
        arrayVietnamese.append(arrayLessonDetail[0].vietnamese6)
        arrayVietnamese.append(arrayLessonDetail[0].vietnamese7)
        
        arrayEnglish.append(arrayLessonDetail[0].english1)
        arrayEnglish.append(arrayLessonDetail[0].english2)
        arrayEnglish.append(arrayLessonDetail[0].english3)
        arrayEnglish.append(arrayLessonDetail[0].english4)
        arrayEnglish.append(arrayLessonDetail[0].english5)
        arrayEnglish.append(arrayLessonDetail[0].english6)
        arrayEnglish.append(arrayLessonDetail[0].english7)
        
        arrayVietnameseShuffle = arrayVietnamese.shuffled()
        arrayEnglishShuffle = arrayEnglish.shuffled()
        
        lbl1.text = arrayVietnameseShuffle[0]
        lbl2.text = arrayVietnameseShuffle[1]
        lbl3.text = arrayVietnameseShuffle[2]
        lbl4.text = arrayVietnameseShuffle[3]
        lbl5.text = arrayVietnameseShuffle[4]
        lbl6.text = arrayVietnameseShuffle[5]
        lbl7.text = arrayVietnameseShuffle[6]
        
        lbl8.text = arrayEnglishShuffle[0]
        lbl9.text = arrayEnglishShuffle[1]
        lbl10.text = arrayEnglishShuffle[2]
        lbl11.text = arrayEnglishShuffle[3]
        lbl12.text = arrayEnglishShuffle[4]
        lbl13.text = arrayEnglishShuffle[5]
        lbl14.text = arrayEnglishShuffle[6]
    }
    
    @IBAction func tapOnDismiss(_ sender: Any) {
        
        viewPopUp.isHidden = true
        viewHuongDan.isHidden = true
        btnDismiss.isHidden = true
    }
    
    func setUpView() {
        
        layoutView(views: [view1, view2, view3, view4, view5, view6, view7, view8, view9, view10, view11, view11, view12, view13, view14])
        
        addBorder(views: [viewHuongDan], width: 1, color: UIColor.darkGray.cgColor)
        addBorder(views: [btnDismiss], width: 0.5, color: UIColor.white.cgColor)
        
        roundCorner(views: [viewHuongDan], radius: 10)
        roundCorner(views: [btnDismiss], radius: btnDismiss.frame.width / 2)
        
        viewPopUp.isHidden = false
        viewHuongDan.isHidden = false
        btnDismiss.isHidden = false
        
        progressBar.setProgress(progressValue, animated: true)
        lblNumber.text = "\(number)/7"
        
    }
    
    func setUpNavigationBar() {
        
        navigationItem.title = "Choose Right Pair"
        
        let leftBarButton = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "alert"), style: .plain, target: self, action: #selector(showPopUp))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc func back() {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func showPopUp() {
        viewPopUp.isHidden = false
        viewHuongDan.isHidden = false
        btnDismiss.isHidden = false
    }
    
    func setUpGesture() {
        
        let tapOnView1 = UITapGestureRecognizer(target: self, action: #selector(chooseAnswer1))
        view1.addGestureRecognizer(tapOnView1)
        
        let tapOnView2 = UITapGestureRecognizer(target: self, action: #selector(chooseAnswer2))
        view2.addGestureRecognizer(tapOnView2)
        
        let tapOnView3 = UITapGestureRecognizer(target: self, action: #selector(chooseAnswer3))
        view3.addGestureRecognizer(tapOnView3)
        
        let tapOnView4 = UITapGestureRecognizer(target: self, action: #selector(chooseAnswer4))
        view4.addGestureRecognizer(tapOnView4)
        
        let tapOnView5 = UITapGestureRecognizer(target: self, action: #selector(chooseAnswer5))
        view5.addGestureRecognizer(tapOnView5)
        
        let tapOnView6 = UITapGestureRecognizer(target: self, action: #selector(chooseAnswer6))
        view6.addGestureRecognizer(tapOnView6)
        
        let tapOnView7 = UITapGestureRecognizer(target: self, action: #selector(chooseAnswer7))
        view7.addGestureRecognizer(tapOnView7)
        
        let tapOnView8 = UITapGestureRecognizer(target: self, action: #selector(chooseAnswer8))
        view8.addGestureRecognizer(tapOnView8)
        
        let tapOnView9 = UITapGestureRecognizer(target: self, action: #selector(chooseAnswer9))
        view9.addGestureRecognizer(tapOnView9)
        
        let tapOnView10 = UITapGestureRecognizer(target: self, action: #selector(chooseAnswer10))
        view10.addGestureRecognizer(tapOnView10)
        
        let tapOnView11 = UITapGestureRecognizer(target: self, action: #selector(chooseAnswer11))
        view11.addGestureRecognizer(tapOnView11)
        
        let tapOnView12 = UITapGestureRecognizer(target: self, action: #selector(chooseAnswer12))
        view12.addGestureRecognizer(tapOnView12)
        
        let tapOnView13 = UITapGestureRecognizer(target: self, action: #selector(chooseAnswer13))
        view13.addGestureRecognizer(tapOnView13)
        
        let tapOnView14 = UITapGestureRecognizer(target: self, action: #selector(chooseAnswer14))
        view14.addGestureRecognizer(tapOnView14)
    }
    
    @objc func chooseAnswer1() {
        
        changeColor(views: vietnameseView, labels: vietnameseLabel)
        view1.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        lbl1.textColor = .white
        vietnamese = lbl1.text!
        viewChoose1 = view1
        index1 = arrayVietnamese.firstIndex(of: vietnamese)!
        lblChoose1 = lbl1!
        checkPair()
    }
    
    @objc func chooseAnswer2() {
        
        changeColor(views: vietnameseView, labels: vietnameseLabel)
        view2.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        lbl2.textColor = .white
        vietnamese = lbl2.text!
        viewChoose1 = view2
        index1 = arrayVietnamese.firstIndex(of: vietnamese)!
        lblChoose1 = lbl2!
        checkPair()
    }
    
    @objc func chooseAnswer3() {
        
        changeColor(views: vietnameseView, labels: vietnameseLabel)
        view3.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        lbl3.textColor = .white
        vietnamese = lbl3.text!
        viewChoose1 = view3
        index1 = arrayVietnamese.firstIndex(of: vietnamese)!
        lblChoose1 = lbl3!
        checkPair()
    }
    
    @objc func chooseAnswer4() {
        
        changeColor(views: vietnameseView, labels: vietnameseLabel)
        view4.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        lbl4.textColor = .white
        vietnamese = lbl4.text!
        viewChoose1 = view4
        index1 = arrayVietnamese.firstIndex(of: vietnamese)!
        lblChoose1 = lbl4!
        checkPair()
    }
    
    @objc func chooseAnswer5() {
        
        changeColor(views: vietnameseView, labels: vietnameseLabel)
        view5.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        lbl5.textColor = .white
        vietnamese = lbl5.text!
        viewChoose1 = view5
        index1 = arrayVietnamese.firstIndex(of: vietnamese)!
        lblChoose1 = lbl5!
        checkPair()
        
    }
    
    @objc func chooseAnswer6() {
        
        changeColor(views: vietnameseView, labels: vietnameseLabel)
        view6.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        lbl6.textColor = .white
        vietnamese = lbl6.text!
        viewChoose1 = view6
        index1 = arrayVietnamese.firstIndex(of: vietnamese)!
        lblChoose1 = lbl6!
        checkPair()
    }
    
    @objc func chooseAnswer7() {
        
        changeColor(views: vietnameseView, labels: vietnameseLabel)
        view7.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        lbl7.textColor = .white
        vietnamese = lbl7.text!
        viewChoose1 = view7
        index1 = arrayVietnamese.firstIndex(of: vietnamese)!
        lblChoose1 = lbl7!
        checkPair()
    }
    
    @objc func chooseAnswer8() {
        
        changeColor(views: englishView, labels: englishLabel)
        view8.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        lbl8.textColor = .white
        english = lbl8.text!
        viewChoose2 = view8
        index2 = arrayEnglish.firstIndex(of: english)!
        lblChoose2 = lbl8!
        checkPair()
    }
    
    @objc func chooseAnswer9() {
        
        changeColor(views: englishView, labels: englishLabel)
        view9.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        lbl9.textColor = .white
        english = lbl9.text!
        viewChoose2 = view9
        index2 = arrayEnglish.firstIndex(of: english)!
        lblChoose2 = lbl9!
        checkPair()
    }
    
    @objc func chooseAnswer10() {
        
        changeColor(views: englishView, labels: englishLabel)
        view10.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        lbl10.textColor = .white
        english = lbl10.text!
        viewChoose2 = view10
        index2 = arrayEnglish.firstIndex(of: english)!
        lblChoose2 = lbl10!
        checkPair()
    }
    
    @objc func chooseAnswer11() {
        
        changeColor(views: englishView, labels: englishLabel)
        view11.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        lbl11.textColor = .white
        english = lbl11.text!
        viewChoose2 = view11
        index2 = arrayEnglish.firstIndex(of: english)!
        lblChoose2 = lbl11!
        checkPair()
    }
    
    @objc func chooseAnswer12() {
        
        changeColor(views: englishView, labels: englishLabel)
        view12.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        lbl12.textColor = .white
        english = lbl12.text!
        viewChoose2 = view12
        index2 = arrayEnglish.firstIndex(of: english)!
        lblChoose2 = lbl12!
        checkPair()
    }
    
    @objc func chooseAnswer13() {
        
        changeColor(views: englishView, labels: englishLabel)
        view13.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        lbl13.textColor = .white
        english = lbl13.text!
        viewChoose2 = view13
        index2 = arrayEnglish.firstIndex(of: english)!
        lblChoose2 = lbl13!
        checkPair()
        
    }
    
    @objc func chooseAnswer14() {
        
        changeColor(views: englishView, labels: englishLabel)
        view14.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        lbl14.textColor = .white
        english = lbl14.text!
        viewChoose2 = view14
        index2 = arrayEnglish.firstIndex(of: english)!
        lblChoose2 = lbl14!
        checkPair()
    }
    
    func checkPair() {
        
        if index1 != -1 && index2 != -1{
            if index1 == index2 {
                
                choosePair(views: [viewChoose1, viewChoose2],
                           color: .white,
                           alpha: 0.5,
                           isUserInteractionEnabled: false,
                           labels: [lblChoose1, lblChoose2]
                )
                
                index1 = -1
                index2 = -1
                numberPaired += 1
                self.progressValue += 1/7
                self.number += 1
                
                DispatchQueue.main.async {
                    
                    
                    self.lblNumber.text = "\(self.number)/7"
                    self.progressBar.setProgress(self.progressValue, animated: true)
                }
            } else {
                
                choosePair(views: [viewChoose1, viewChoose2],
                           color: .white,
                           alpha: 1,
                           isUserInteractionEnabled: true,
                           labels: [lblChoose1, lblChoose2]
                )
                
                index1 = -1
                index2 = -1
                
                setUpToast()
            }
        }
        
        if numberPaired == 7 {
            let resultVC = ResultVC(nibName: "ResultVC", bundle: nil)
            resultVC.imageTopic = self.imageTopic
            
            self.navigationController?.pushViewController(resultVC, animated: true)
        }
    }
    
    func choosePair(views: [UIView], color: UIColor, alpha: CGFloat, isUserInteractionEnabled : Bool, labels: [UILabel] ) {
        
        for view in views {
            
            view.backgroundColor = color
            view.alpha = alpha
            view.isUserInteractionEnabled = isUserInteractionEnabled
        }
        
        for label in labels {
            
            label.textColor = .black
        }
    }
    
    func setUpToast() {
        
        style.backgroundColor = #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)
        style.messageColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        style.messageFont = UIFont(name: "AvenirNext-Regular", size: 16)!
        self.view.makeToast("Bạn đã chọn sai", duration: 2.0, position: .top, style: style)
    }
}
