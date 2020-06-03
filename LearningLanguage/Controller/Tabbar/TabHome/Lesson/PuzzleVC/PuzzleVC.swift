//
//  PuzzleVC.swift
//  LearningLanguage
//
//  Created by Linh Nguyen on 2/25/20.
//  Copyright © 2020 NguyenQuocViet. All rights reserved.
//

import UIKit
import SwiftEntryKit
import Firebase

class PuzzleVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var viewWord: UIView!
    @IBOutlet weak var imgWord: UIImageView!
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var viewCollectionView: UIView!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var viewPopUp: UIView!
    @IBOutlet weak var viewHuongDan: UIView!
    @IBOutlet weak var btnDismiss: UIButton!
    
    var imageTopic = ""
    var titleLesson = "Sắp xếp chữ cái "
    var topic = ""
    var lesson = ""
    var check = true
    var number = 1
    var index = 0
    
    var arrayLessonDetail = [LessonDetail]()
    var arrayWord = [String]()
    var arrayQuestion = [String]()
    
    var word = ""
    var letters = [String]()
    var shuffledLetters = [String]()
    var arrangedWord = ""

    var lblDescription = ""
    var titlePopUp = ""
    var imagePopUp = ""
    var nameButton = ""
    var backgroundColor : UIColor!
    var descriptionColor : UIColor!
    
    var progressValue : Float = 1/7
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUpCollectionView()
        setUpView()
        setUpNavigationBar()
        getDataFromFirebase()
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
                    
                    self.arrayWord.append(self.arrayLessonDetail[0].english1)
                    self.arrayWord.append(self.arrayLessonDetail[0].english2)
                    self.arrayWord.append(self.arrayLessonDetail[0].english3)
                    self.arrayWord.append(self.arrayLessonDetail[0].english4)
                    self.arrayWord.append(self.arrayLessonDetail[0].english5)
                    self.arrayWord.append(self.arrayLessonDetail[0].english6)
                    self.arrayWord.append(self.arrayLessonDetail[0].english7)
                    
                    self.arrayQuestion.append(self.arrayLessonDetail[0].vietnamese1)
                    self.arrayQuestion.append(self.arrayLessonDetail[0].vietnamese2)
                    self.arrayQuestion.append(self.arrayLessonDetail[0].vietnamese3)
                    self.arrayQuestion.append(self.arrayLessonDetail[0].vietnamese4)
                    self.arrayQuestion.append(self.arrayLessonDetail[0].vietnamese5)
                    self.arrayQuestion.append(self.arrayLessonDetail[0].vietnamese6)
                    self.arrayQuestion.append(self.arrayLessonDetail[0].vietnamese7)
                    
                    self.setUpData()
                    self.collectionView.reloadData()
                    
                    hideLoading(viewCtrl: self)
                }
            }
        }
    }
    
    func setUpNavigationBar() {
        
        navigationItem.title = "Arrange Word"
        
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
    
    func setUpCollectionView() {
        
        let puzzleCell_xib = UINib(nibName: "PuzzleCell", bundle: nil)
        collectionView.register(puzzleCell_xib, forCellWithReuseIdentifier: "puzzleCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
        collectionView.dragInteractionEnabled = true
    }
    
    func setUpData() {
        
        print(arrayWord.count)
        
        word = arrayWord[index]
        letters = word.uppercased().map{String($0)}
        imgWord.image = UIImage(named : arrayWord[index].lowercased())
        lblQuestion.text = arrayQuestion[index]
        shuffledLetters = letters.shuffled()
    }
    
    func setUpView() {
        roundCorner(views: [viewWord], radius: 10)
        roundCorner(views: [imgWord], radius: 10)
        roundCorner(views: [viewCollectionView], radius: 10)
        roundCorner(views: [btnCheck], radius: 10)
        roundCorner(views: [viewHuongDan], radius: 10)
        roundCorner(views: [btnDismiss], radius: btnDismiss.frame.width / 2)
        
        layoutView(views: [viewWord])
        
        addBorder(views: [viewHuongDan], width: 1, color: UIColor.darkGray.cgColor)
        addBorder(views: [btnDismiss], width: 0.5, color: UIColor.white.cgColor)
        
        viewPopUp.isHidden = false
        viewHuongDan.isHidden = false
        btnDismiss.isHidden = false
        
        progressBar.setProgress(progressValue, animated: true)
        lblNumber.text = "\(number)/7"

    }
    
    @IBAction func tapOnDismiss(_ sender: Any) {
        viewPopUp.isHidden = true
        viewHuongDan.isHidden = true
        btnDismiss.isHidden = true
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
                        
            if self.check == true {
                self.index += 1
                
                if self.index == self.arrayWord.count {
                    
                    let resultVC = ResultVC(nibName: "ResultVC", bundle: nil)
                    resultVC.imageTopic = self.imageTopic
                    self.navigationController?.pushViewController(resultVC, animated: true)
                } else {
                    
                    self.progressValue += 1/7
                    self.number += 1
                    
                    DispatchQueue.main.async {
                        
                        self.setUpData()
                        self.collectionView.reloadData()
                        self.lblNumber.text = "\(self.number)/7"
                        self.progressBar.setProgress(self.progressValue, animated: true)
                    }
                }
            } else {
                
                self.lblNumber.text = "\(self.number)/10"
                self.progressBar.setProgress(self.progressValue, animated: true)
                
            }
        }
        
        let popUpView = EKPopUpMessageView(with: popUpMessage)
        SwiftEntryKit.display(entry: popUpView, using: attributes)
        
    }
    
    @IBAction func tapOnCheck(_ sender: Any) {
        if arrangedWord == word.uppercased() {
            
            lblDescription = "Bạn đã trả lời đúng !"
            titlePopUp = "Tuyệt vời!"
            imagePopUp = "checked"
            backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            descriptionColor  = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
            check = true
            nameButton = "Câu tiếp theo"
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

extension PuzzleVC: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return letters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "puzzleCell", for: indexPath as IndexPath) as! PuzzleCell
        cell.lblLetter.text = shuffledLetters[indexPath.item]
        cell.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.cyan
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    }
}

extension PuzzleVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        var totalCellWidth = 0
        var topInset = 0
        
        if letters.count <= 8 {
            totalCellWidth = 40 * letters.count
            topInset = 15
        } else {
            totalCellWidth = 32 * letters.count
            topInset = 20
        }
        
        let totalSpacingWidth = 5 * (letters.count - 1)
        let leftInset = (collectionView.frame.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        
        return UIEdgeInsets(top: CGFloat(topInset), left: leftInset, bottom: 0, right: rightInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if letters.count <= 8 {
            return CGSize(width: 40, height: 40)
        } else {
            return CGSize(width: 32, height: 32)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

extension PuzzleVC: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        
        let letter = self.shuffledLetters[indexPath.item]
        let letterProvider = NSItemProvider(object: letter as NSString)
        let dragItem = UIDragItem(itemProvider: letterProvider)
        dragItem.localObject = letter
        dragItem.previewProvider = nil
        return [dragItem]
    }
}

extension PuzzleVC: UICollectionViewDropDelegate {
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        
        if collectionView.hasActiveDrag {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UICollectionViewDropProposal(operation: .forbidden)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        
        var destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let row = collectionView.numberOfItems(inSection: 0)
            destinationIndexPath = IndexPath(item: row - 1, section: 0)
        }
        
        if coordinator.proposal.operation == .move {
            self.reorderItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath, collectionView: collectionView)
        }
    }
    
    func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
        
        if let character = coordinator.items.first,
            let sourceIndexPath = character.sourceIndexPath {
            
            collectionView.performBatchUpdates({
                self.shuffledLetters.remove(at: sourceIndexPath.item)
                self.shuffledLetters.insert(character.dragItem.localObject as! String, at: destinationIndexPath.item)
                
                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [destinationIndexPath])
                
                arrangedWord = shuffledLetters.joined(separator: "")
                
            }, completion: nil)
            coordinator.drop(character.dragItem, toItemAt: destinationIndexPath)
        }
    }
}
