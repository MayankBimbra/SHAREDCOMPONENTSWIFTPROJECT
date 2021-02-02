//
//  tabbarVC.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 21/12/20.
//

import UIKit

class tabbarVC: UITabBarController {

    let ChatScreenTitle = "CHAT"
    let NotificationScreenTitle = "NOTIFICATION"

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = UIColor.appWhiteColor
        self.tabBar.tintColor = UIColor.themeColor
        
        self.delegate = self
    }
}


extension tabbarVC: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.title == ChatScreenTitle || viewController.title == NotificationScreenTitle{
            if userData.shared.accessToken == ""{
                let popOverVC = loginAskPopUp()
                self.addChild(popOverVC)
                popOverVC.view.frame = self.view.frame
                self.view.addSubview(popOverVC.view)
                popOverVC.didMove(toParent: self)
                return false
            }
        }
        return true
    }
}
