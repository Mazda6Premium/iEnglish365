//
//  SelectionVC.swift
//  LearningLanguage
//
//  Created by Linh Nguyen on 2/18/20.
//  Copyright © 2020 NguyenQuocViet. All rights reserved.
//

import UIKit
import SwiftEntryKit

class SelectionVC: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var viewAnswer1: UIView!
    @IBOutlet weak var viewAnswer2: UIView!
    @IBOutlet weak var viewAnswer3: UIView!
    @IBOutlet weak var viewAnswer4: UIView!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var lblAnswer1: UILabel!
    @IBOutlet weak var lblAnswer2: UILabel!
    @IBOutlet weak var lblAnswer3: UILabel!
    @IBOutlet weak var lblAnswer4: UILabel!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var viewPopUp: UIView!
    @IBOutlet weak var viewHuongDan: UIView!
    @IBOutlet weak var btnDismiss: UIButton!
    
    var arrayLessonDetail = [LessonDetail]()
    var arrayAnswer = [String]()
    var arrayQuestion = [String]()
    var lblRandom : UILabel!
    var opA = ""
    var opB = ""
    var opC = ""
    var opD = ""
    var arrayAnswerOp = [String]()
    var randomIndexOp = -1
    var indexOp1 = -1
    var indexOp2 = -1
    var indexOp3 = -1
    var indexCorrectAns = -1
    
    var correctAnswer = ""
    var answer = ""
    var index = 0
    var viewsAnswer = [UIView]()
    var lblsAnswer = [UILabel]()
    var progressValue : Float = 1/7
    var number = 1
    var numberOfCorrectAnswer = 0
    var imageTopic = ""
    var check = true
    var topic = ""
    var lesson = ""
    
    var lblDescription = ""
    var titlePopUp = ""
    var imagePopUp = ""
    var nameButton = ""
    var backgroundColor : UIColor!
    var descriptionColor : UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrayAnswerOp = [opA, opB, opC, opD]
        
        setUpView()
        setUpGesture()
        setUpNavigationBar()
        getDataFromFirebase()
        
        viewsAnswer = [viewAnswer1, viewAnswer2, viewAnswer3, viewAnswer4]
        lblsAnswer = [lblAnswer1, lblAnswer2, lblAnswer3, lblAnswer4]
        
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
                    
                    self.arrayQuestion.append(self.arrayLessonDetail[0].vietnamese1)
                    self.arrayQuestion.append(self.arrayLessonDetail[0].vietnamese2)
                    self.arrayQuestion.append(self.arrayLessonDetail[0].vietnamese3)
                    self.arrayQuestion.append(self.arrayLessonDetail[0].vietnamese4)
                    self.arrayQuestion.append(self.arrayLessonDetail[0].vietnamese5)
                    self.arrayQuestion.append(self.arrayLessonDetail[0].vietnamese6)
                    self.arrayQuestion.append(self.arrayLessonDetail[0].vietnamese7)
                    
                    self.arrayAnswer.append(self.arrayLessonDetail[0].english1)
                    self.arrayAnswer.append(self.arrayLessonDetail[0].english2)
                    self.arrayAnswer.append(self.arrayLessonDetail[0].english3)
                    self.arrayAnswer.append(self.arrayLessonDetail[0].english4)
                    self.arrayAnswer.append(self.arrayLessonDetail[0].english5)
                    self.arrayAnswer.append(self.arrayLessonDetail[0].english6)
                    self.arrayAnswer.append(self.arrayLessonDetail[0].english7)
                    
                    self.loadData()
                    
                    
                    hideLoading(viewCtrl: self)
                }
            }
        }
    }
    
    func loadData() {
        
        lblQuestion.text = arrayQuestion[index]
        correctAnswer = arrayAnswer[index]
        
        randomIndexOp = [0,1,2,3].randomElement()!
        print(randomIndexOp)
        arrayAnswerOp[randomIndexOp] = correctAnswer
        
        indexCorrectAns = arrayAnswer.firstIndex(of: correctAnswer)!
        
        while indexOp1 == -1  || indexOp1 == indexCorrectAns {
            indexOp1 = Array(0...6).randomElement()!
        }
        
        while indexOp2 == -1 || indexOp2 == indexOp1 || indexOp2 == indexCorrectAns {
            indexOp2 = Array(0...6).randomElement()!
        }
        
        while indexOp3 == -1 || indexOp3 == indexOp2 || indexOp3 == indexOp1 || indexOp3 == indexCorrectAns {
            indexOp3 = Array(0...6).randomElement()!
        }
        
        if arrayAnswerOp[0] == correctAnswer {
            arrayAnswerOp[1] = arrayAnswer[indexOp1]
            arrayAnswerOp[2] = arrayAnswer[indexOp2]
            arrayAnswerOp[3] = arrayAnswer[indexOp3]
        }
        
        if arrayAnswerOp[1] == correctAnswer {
            arrayAnswerOp[0] = arrayAnswer[indexOp1]
            arrayAnswerOp[2] = arrayAnswer[indexOp2]
            arrayAnswerOp[3] = arrayAnswer[indexOp3]
        }
        
        if arrayAnswerOp[2] == correctAnswer {
            arrayAnswerOp[0] = arrayAnswer[indexOp1]
            arrayAnswerOp[1] = arrayAnswer[indexOp2]
            arrayAnswerOp[3] = arrayAnswer[indexOp3]
        }
        
        if arrayAnswerOp[3] == correctAnswer {
            arrayAnswerOp[0] = arrayAnswer[indexOp1]
            arrayAnswerOp[1] = arrayAnswer[indexOp2]
            arrayAnswerOp[2] = arrayAnswer[indexOp3]
        }
        
        self.lblAnswer1.text! = arrayAnswerOp[0]
        self.lblAnswer2.text! = arrayAnswerOp[1]
        self.lblAnswer3.text! = arrayAnswerOp[2]
        self.lblAnswer4.text! = arrayAnswerOp[3]
        
        img1.image = UIImage(named : (lblAnswer1.text?.lowercased())!)
        img2.image = UIImage(named : (lblAnswer2.text?.lowercased())!)
        img3.image = UIImage(named : (lblAnswer3.text?.lowercased())!)
        img4.image = UIImage(named : (lblAnswer4.text?.lowercased())!)

    }
    
    func setUpView() {
        
        layoutView(views: [viewAnswer1, viewAnswer2, viewAnswer3, viewAnswer4])
        
        roundCorner(views: [btnCheck], radius: 10)
        roundCorner(views: [viewHuongDan], radius: 10)
        roundCorner(views: [btnDismiss], radius: btnDismiss.frame.width / 2)
        
        progressBar.setProgress(progressValue, animated: true)
        
        lblNumber.text = "\(number)/7"
        
        btnCheck.isUserInteractionEnabled = false
        btnCheck.alpha = 0.5
        
        addBorder(views: [viewHuongDan], width: 1, color: UIColor.darkGray.cgColor)
        addBorder(views: [btnDismiss], width: 0.5, color: UIColor.white.cgColor)
        
        viewPopUp.isHidden = false
        viewHuongDan.isHidden = false
        btnDismiss.isHidden = false
        
    }
    
    func setUpNavigationBar() {
        
        navigationItem.title = "Selection Right Answer"
        
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
    
    @IBAction func tapOnDismiss(_ sender: Any) {
        
        viewPopUp.isHidden = true
        viewHuongDan.isHidden = true
        btnDismiss.isHidden = true
    }
    
    func setUpGesture() {
        
        let tapOnView1 = UITapGestureRecognizer(target: self, action: #selector(chooseAnswer1))
        viewAnswer1.addGestureRecognizer(tapOnView1)
        
        let tapOnView2 = UITapGestureRecognizer(target: self, action: #selector(chooseAnswer2))
        viewAnswer2.addGestureRecognizer(tapOnView2)
        
        let tapOnView3 = UITapGestureRecognizer(target: self, action: #selector(chooseAnswer3))
        viewAnswer3.addGestureRecognizer(tapOnView3)
        
        let tapOnView4 = UITapGestureRecognizer(target: self, action: #selector(chooseAnswer4))
        viewAnswer4.addGestureRecognizer(tapOnView4)
    }
    
    @objc func chooseAnswer1() {
        
        changeColor(views: viewsAnswer, labels: lblsAnswer)
        
        viewAnswer1.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        lblAnswer1.textColor = .white
        
        answer = lblAnswer1.text!
        print(answer)
        
        btnCheck.isUserInteractionEnabled = true
        btnCheck.alpha = 1
        
    }
    
    @objc func chooseAnswer2() {
        
        changeColor(views: viewsAnswer, labels: lblsAnswer)
        
        viewAnswer2.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        lblAnswer2.textColor = .white
        
        answer = lblAnswer2.text!
        print(answer)

        btnCheck.isUserInteractionEnabled = true
        btnCheck.alpha = 1
        
    }
    
    @objc func chooseAnswer3() {
        
        changeColor(views: viewsAnswer, labels: lblsAnswer)
        
        viewAnswer3.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        lblAnswer3.textColor = .white
        
        answer = lblAnswer3.text!
        print(answer)

        btnCheck.isUserInteractionEnabled = true
        btnCheck.alpha = 1
    }
    
    @objc func chooseAnswer4() {
        
        changeColor(views: viewsAnswer, labels: lblsAnswer)
        
        viewAnswer4.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        lblAnswer4.textColor = .white
        
        answer = lblAnswer4.text!
        print(answer)

        btnCheck.isUserInteractionEnabled = true
        btnCheck.alpha = 1
    }
    
    func setUpPopView() {
        
        var attributes = EKAttributes.bottomFloat
        attributes.border = .value(color: .brown, width: 1)
        attributes.roundCorners = .all(radius: 25)
        attributes.displayDuration = .infinity
        attributes.displayMode = .dark
        attributes.entryBackground = .color(color: .init(backgroundColor))
        attributes.screenBackground = .visualEffect(style: .init(light: .extraLight, dark: .dark))
        attributes.position = .bottom
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .disabled
        attributes.entranceAnimation = .init(translate: .init(duration: 0.24), scale: .none, fade: .none)
        attributes.exitAnimation = .init(translate: .init(duration: 0.24), scale: .none, fade: .none)
        attributes.shadow = .active(with: .init(color: .init(.darkGray), opacity: 0.5, radius: 10, offset: CGSize(width: 2, height: 2)))
        
        let widthConstraint = EKAttributes.PositionConstraints.Edge.ratio(value: 0.8)
        let heightConstraint = EKAttributes.PositionConstraints.Edge.offset(value: 20)
        attributes.positionConstraints.maxSize  = .init(width: widthConstraint, height: heightConstraint)
        
        let titleStyle = EKProperty.LabelStyle(
            
            font: UIFont(name: "AvenirNext-Regular", size: 30)!,
            color: .init(.black),
            alignment: .center,
            displayMode: .light,
            numberOfLines: 1
            
        )
        
        let title = EKProperty.LabelContent(text: titlePopUp, style: titleStyle)
        
        let descriptonStyle =  EKProperty.LabelStyle(
            
            font: UIFont(name: "AvenirNext-DemiBold", size: 18)!,
            color: .init(descriptionColor),
            alignment: .center,
            displayMode: .light,
            numberOfLines: 2
            
        )
        
        let description = EKProperty.LabelContent(text: lblDescription, style: descriptonStyle)
        
        let titleButton = EKProperty.LabelContent(
            
            text: nameButton,
            style: .init(font: UIFont(name: "AvenirNext-DemiBold", size: 17)!,
                         color: .white,
                         alignment: .center,
                         displayMode: .light,
                         numberOfLines: 1)
            
        )
        
        let image = EKProperty.ImageContent(
            
            imageName: imagePopUp,
            animation: .none,
            displayMode: .light,
            size: CGSize(width: 75, height: 75),
            contentMode: .scaleAspectFill,
            tint: .black,
            makesRound: true,
            accessibilityIdentifier: .none
            
        )
        
        let themeImage = EKPopUpMessage.ThemeImage(image: image, position: .topToTop(offset: 30))
        
        
        let button = EKProperty.ButtonContent(
            
            label: titleButton,
            backgroundColor: .init(.orange),
            highlightedBackgroundColor: .clear
            
        )
        
        let popUpMessage = EKPopUpMessage(themeImage: themeImage, title: title, description: description, button: button) {
            
            SwiftEntryKit.dismiss()
            
            self.answer = ""
            
            if self.check == true {
                self.index += 1
                
                if self.index == self.arrayQuestion.count {
                    
                    let resultVC = ResultVC(nibName: "ResultVC", bundle: nil)
                    resultVC.result = self.numberOfCorrectAnswer
                    resultVC.imageTopic = self.imageTopic
                    self.navigationController?.pushViewController(resultVC, animated: true)
                } else {
                    
                    self.progressValue += 1/7
                    self.number += 1
                    
                    DispatchQueue.main.async {
                        
                        self.loadData()
                        
                        changeColor(views: self.viewsAnswer, labels: self.lblsAnswer)
                        
                        self.lblNumber.text = "\(self.number)/7"
                        self.progressBar.setProgress(self.progressValue, animated: true)
                    }
                }
                
            } else {
                changeColor(views: self.viewsAnswer, labels: self.lblsAnswer)
                
                self.lblNumber.text = "\(self.number)/7"
                self.progressBar.setProgress(self.progressValue, animated: true)
                
            }
            
            self.viewAnswer1.isUserInteractionEnabled = true
            self.viewAnswer2.isUserInteractionEnabled = true
            self.viewAnswer3.isUserInteractionEnabled = true
            self.viewAnswer4.isUserInteractionEnabled = true
            
            self.btnCheck.isUserInteractionEnabled = false
            self.btnCheck.alpha = 0.5
            
        }
        
        let popUpView = EKPopUpMessageView(with: popUpMessage)
        SwiftEntryKit.display(entry: popUpView, using: attributes)
        
    }
    
    @IBAction func tapOnCheck(_ sender: Any) {
        
        viewAnswer1.isUserInteractionEnabled = false
        viewAnswer2.isUserInteractionEnabled = false
        viewAnswer3.isUserInteractionEnabled = false
        viewAnswer4.isUserInteractionEnabled = false
        
        if answer.lowercased() == correctAnswer.lowercased() {
            lblDescription = "Bạn đã trả lời đúng !"
            titlePopUp = "Tuyệt vời!"
            imagePopUp = "checked"
            numberOfCorrectAnswer += 1
            backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            descriptionColor  = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
            check = true
            nameButton = "Câu tiếp theo"
            
            indexOp1 = -1
            indexOp2 = -1
            indexOp3 = -1
            
            
        } else {
            lblDescription = "Bạn chưa trả lời đúng.Thử thêm lần nữa nào."
            titlePopUp = "Cố gắng lên."
            imagePopUp = "cancel"
            backgroundColor = #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)
            descriptionColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            check = false
            nameButton = "Thử lại"
        }
        
        setUpPopView()
    }
    
    
}
