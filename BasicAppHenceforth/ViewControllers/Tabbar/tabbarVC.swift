//
//  tabbarVC.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 21/12/20.
//

import UIKit

class tabbarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = UIColor.appWhiteColor
        self.tabBar.tintColor = UIColor.themeColor
        
        if userData.shared.accessToken == ""{
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                let popOverVC = loginAskPopUp()
                self.addChild(popOverVC)
                popOverVC.view.frame = self.view.frame
                self.view.addSubview(popOverVC.view)
                popOverVC.didMove(toParent: self)
            }
        }
    }
}
