//
//  TabPuzzleVC.swift
//  LearningLanguage
//
//  Created by Linh Nguyen on 6/2/20.
//  Copyright © 2020 NguyenQuocViet. All rights reserved.
//

import UIKit

class TabPuzzleVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var arrayTopic = [
        Topic(imgTopic: "animal", lblTopic: "Animal"),
        Topic(imgTopic: "clothes", lblTopic: "Clothes"),
        Topic(imgTopic: "food", lblTopic: "Food"),
        Topic(imgTopic: "kitchen", lblTopic: "Kitchen"),
        Topic(imgTopic: "vehicle", lblTopic: "Vehicle"),
        Topic(imgTopic: "job", lblTopic: "Job"),
        Topic(imgTopic: "sport", lblTopic: "Sport"),
        Topic(imgTopic: "tool", lblTopic: "Tool"),
        Topic(imgTopic: "stationery", lblTopic: "Stationery")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpNavigationBar()
        setUpTableView()
    }
    
override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    
    func setUpTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    func setUpNavigationBar() {
        
        navigationItem.title = "Arrange word"
        navigationController?.navigationBar.tintColor = .white
        
//        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
//        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
//    @objc func add(){
//        let vc = PushLessonVC(nibName: "PushLessonVC", bundle: nil)
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
}
   
extension TabPuzzleVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayTopic.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! HomeCell
        let topic = arrayTopic[indexPath.row]
        cell.selectionStyle = .none
        cell.imgTopic.image = UIImage(named: topic.imgTopic)
        cell.imgTopic.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        cell.lblTopic.text = topic.lblTopic
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let lessonVC = LessonVC(nibName: "LessonVC", bundle: nil)
        let topic = arrayTopic[indexPath.row]
        lessonVC.titleTopic = topic.lblTopic
        lessonVC.exerciseType = .Puzzle
        lessonVC.topic = topic.lblTopic
        lessonVC.imageTopic = topic.imgTopic
        self.navigationController?.pushViewController(lessonVC, animated: true)
    }
    
}

