//
//  StoryBoard.swift
//  Lowicks
//
//  Created by MAC on 03/09/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import UIKit

enum AppStoryboard : String {
    
    case Main = "Main"
    case Tabbar = "Tabbar"
    case Profile = "Profile"
    case Account = "Account"
//    case CreateListing = "CreateListing"

    var instance: UIStoryboard{
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewControllerClass : T.Type) -> T{
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }
    
    func initialViewController() -> UIViewController?{
        return instance.instantiateInitialViewController()
    }
}


extension UIViewController {
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func instantiateFromAppStoryboard(appStoryboard: AppStoryboard) -> Self{
        return appStoryboard.viewController(viewControllerClass: self)
    }
}
