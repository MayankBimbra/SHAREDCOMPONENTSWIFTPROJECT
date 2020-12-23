//
//  notificationAskVC.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 23/12/20.
//

import UIKit

class notificationAskVC: headerVC {

    // MARK: - VARIABLES
    
    
    // MARK: - UI COMPONENTS
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var switchEmail: UISwitch!
    
    @IBOutlet weak var lblPushNotification: UILabel!
    @IBOutlet weak var switchPushNotification: UISwitch!
    @IBOutlet weak var lblPushNotificationDesc: UILabel!
    
    
    // MARK: - OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        isBackEnabled = true
        super.viewDidLoad()
        setUpUI()
    }
}


// MARK: - SET UP UI
extension notificationAskVC{
    func setUpUI(){
        lblHeader.text = L10n.Notifications.description
        
        lblEmail.textColor = UIColor.appBlackColor
        lblEmail.text = L10n.EmailNot.description
        lblEmail.font = UIFont.MontserratMedium(Size.Large.sizeValue())
        
        lblPushNotification.textColor = UIColor.appBlackColor
        lblPushNotification.text = L10n.PushNotification.description
        lblPushNotification.font = UIFont.MontserratMedium(Size.Large.sizeValue())

        lblPushNotificationDesc.textColor = UIColor.textColorTwo
        lblPushNotificationDesc.text = L10n.PushNotificationDesc.description
        lblPushNotificationDesc.font = UIFont.MontserratMedium(Size.Small.sizeValue())
        
        switchEmail.onTintColor = UIColor.themeColor
        switchEmail.thumbTintColor = UIColor.appWhiteColor

        switchPushNotification.onTintColor = UIColor.themeColor
        switchPushNotification.thumbTintColor = UIColor.white

        
    }
}
