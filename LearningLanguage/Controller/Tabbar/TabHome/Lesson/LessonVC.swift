//
//  LessonVC.swift
//  LearningLanguage
//
//  Created by Linh Nguyen on 2/19/20.
//  Copyright © 2020 NguyenQuocViet. All rights reserved.
//

import UIKit
import Firebase

enum ExerciseType {
    case Selection
    case Pair
    case Puzzle
}

class LessonVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var titleTopic = ""
    var imageTopic = ""
    var topic = ""
    var arrayLesson = [String]()
    var index : Int = 0
    var exerciseType : ExerciseType = ExerciseType.Selection
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        getDataFromFirebase()
        setUpNavigationBar()
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func getDataFromFirebase() {
        showLoading(viewCtrl: self)
        databaseReference.child("Data").child(topic).observe(.childAdded) { (data) in
            databaseReference.child("Data").child(self.topic).child(data.key).observe(.value) { (snap) in
                if let dict = snap.key as? String {
                    self.arrayLesson.append(dict)
                    self.tableView.reloadData()
                    hideLoading(viewCtrl: self)
                }
            }
        }
    }
    
    func setUpTableView() {
        
        let lessonCell_xib = UINib(nibName: "LessonCell", bundle: nil)
        tableView.register(lessonCell_xib, forCellReuseIdentifier: "lessonCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    func setUpNavigationBar() {
        
        navigationItem.title = titleTopic
        
        let leftBarButton = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension LessonVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayLesson.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "lessonCell") as! LessonCell
        cell.selectionStyle = .none
        cell.lessonTitle.text = arrayLesson[indexPath.row]
        cell.imgLesson.image = UIImage(named: imageTopic)
        cell.imgLesson.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        index = indexPath.row
        switch exerciseType {
        case .Selection:
            let selectionVC = SelectionVC(nibName: "SelectionVC", bundle: nil)
            selectionVC.imageTopic = imageTopic
            selectionVC.topic = topic
            selectionVC.lesson = arrayLesson[index]
            self.navigationController?.pushViewController(selectionVC, animated: true)
        case .Pair:
            let pairVC = PairVC(nibName: "PairVC", bundle: nil)
            pairVC.imageTopic = imageTopic
            pairVC.topic = topic
            pairVC.lesson = arrayLesson[index]
            self.navigationController?.pushViewController(pairVC, animated: true)
        case .Puzzle:
            let puzzleVC = PuzzleVC(nibName: "PuzzleVC", bundle: nil)
            puzzleVC.imageTopic = imageTopic
            puzzleVC.topic = topic
            puzzleVC.lesson = arrayLesson[index]
            self.navigationController?.pushViewController(puzzleVC, animated: true)
        }
        
    }
}
