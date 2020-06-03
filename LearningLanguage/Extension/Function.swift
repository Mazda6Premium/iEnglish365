//
//  Function.swift
//  LearningLanguage
//
//  Created by Linh Nguyen on 2/18/20.
//  Copyright © 2020 NguyenQuocViet. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import JGProgressHUD

let databaseReference = Database.database().reference()
let storageReference = Storage.storage().reference()
let userDefaults = UserDefaults.standard
let dateFormatter = DateFormatter()
var loadingHud = JGProgressHUD(style: .dark)
//let adminId = "fWX9tU9wSRWJ0tYsdWFzu8nGrGx2"

func roundCorner(views: [UIView], radius: CGFloat) {
    
    views.forEach { (view) in
        view.layer.cornerRadius = radius
        view.layer.masksToBounds = true
    }
    
}

func addBorder(views: [UIView], width: CGFloat, color: CGColor) {
    
    views.forEach { (view) in
        view.layer.borderWidth = width
        view.layer.borderColor = color
    }
    
}

func layoutView(views: [UIView]) {
    
    views.forEach { (view) in
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.clipsToBounds = false
        view.backgroundColor = .white
    }
    
}

func showLoading(viewCtrl: UIViewController) {
    loadingHud.show(in: viewCtrl.view)
}

func hideLoading(viewCtrl: UIViewController) {
    loadingHud.dismiss()
}

func showSuccess(viewCtrl: UIViewController) {
    loadingHud.dismiss()
    let successHud = JGProgressHUD(style: .dark)
    successHud.indicatorView = JGProgressHUDSuccessIndicatorView()
    successHud.show(in: viewCtrl.view)
    successHud.dismiss(afterDelay: 2)
}

func changeColor(views :[UIView],labels :[UILabel]) {
    
    for view in views {
        
        view.backgroundColor = .white
    }
    
    for label in labels {
        
        label.textColor = .black
    }
}

extension UIView {
    func startRotating(duration: Double, clockwise: Bool) {
        
        let kAnimationKey = "rotation"
        var currentState = CGFloat(0)
        
        // Get current state
        if let presentationLayer = layer.presentation(), let zValue = presentationLayer.value(forKeyPath: "transform.rotation.z") {
            
            currentState = CGFloat((zValue as AnyObject).floatValue)
        }
        
        if self.layer.animation(forKey: kAnimationKey) == nil {
            
            let animate = CABasicAnimation(keyPath: "transform.rotation")
            animate.duration = duration
            animate.repeatCount = Float.infinity
            animate.fromValue = currentState //Should the value be nil, will start from 0 a.k.a. "the beginning".
            animate.byValue = clockwise ? Float(Double.pi * 2.0) : -Float(Double.pi * 2.0)
            self.layer.add(animate, forKey: kAnimationKey)
        }
    }
    
    func dropShadow(color: UIColor, opacity: Float, offSet: CGSize, radius: CGFloat, scale: Bool) {
        
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        clipsToBounds = false
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
