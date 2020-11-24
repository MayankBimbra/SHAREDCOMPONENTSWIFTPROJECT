////
////  CustomLoader.swift
////  Auction
////
////  Created by Gaurav on 20/10/19.
////  Copyright © 2019 VIVEK. All rights reserved.
////
//
//import Foundation
//
//import UIKit
//
//class CustomLoader: UIView {
//    
//    static let instance = CustomLoader()
//    
//    var viewColor: UIColor = .black
//    var setAlpha: CGFloat = 0.5
//    var gifName: String = "defaultLoader"
//    var showingLoader = false
//    
//    lazy var transparentView: UIView = {
//        let transparentView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
//        transparentView.backgroundColor = viewColor.withAlphaComponent(setAlpha)
//      //  transparentView.isUserInteractionEnabled = false
//        return transparentView
//    }()
//    
//    lazy var gifImage: UIImageView = {
//        var gifImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 45))
//        gifImage.contentMode = .scaleAspectFit
//        gifImage.center = transparentView.center
//        gifImage.isUserInteractionEnabled = false
//        gifImage.loadGif(name: gifName)
//        return gifImage
//    }()
//    
//    func showLoaderView() {
//        //if self.showingLoader == false {
//        self.showingLoader = true
//        self.addSubview(self.transparentView)
//        self.transparentView.addSubview(self.gifImage)
//        self.transparentView.bringSubviewToFront(self.gifImage)
//        UIApplication.shared.keyWindow?.addSubview(transparentView)
//        //}
//    }
//    
//    func hideLoaderView() {
//        self.showingLoader = false
//        self.transparentView.removeFromSuperview()
//    }
//    
//}
