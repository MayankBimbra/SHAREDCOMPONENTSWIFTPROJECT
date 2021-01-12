//
//  notificationAskVC.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 23/12/20.
//

import UIKit

class notificationAskVC: headerVC {

    // MARK: - VARIABLES
    var notificationAskVM : NotificationAskVM = NotificationAskVM.shared

    
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
        setData()
    }
}


// MARK: - SET UP UI
extension notificationAskVC{
    func setUpUI(){
        notificationAskVM.controller = self

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

        switchEmail.addTarget(self, action: #selector(switchActEmail(_:)), for: .valueChanged)
        switchPushNotification.addTarget(self, action: #selector(switchActPush(_:)), for: .valueChanged)

        btnRight.setTitle(L10n.SAVE.description, for: .normal)
        btnRight.addTarget(self, action: #selector(btnActSave(_:)), for: .touchUpInside)
        btnRight.isHidden = true

    }
    
    func setData(){
        if userData.shared.isEmailNotified == 1{
            switchEmail.setOn(true, animated: false)
        }else{
            switchEmail.setOn(false, animated: false)
        }
        
        if userData.shared.isPushNotified == 1{
            switchPushNotification.setOn(true, animated: false)
        }else{
            switchPushNotification.setOn(false, animated: false)
        }
        
        notificationAskVM.emailNotified = userData.shared.isEmailNotified
        notificationAskVM.pushNotified = userData.shared.isPushNotified
        notificationAskVM.smsNotified = userData.shared.isSMSNotified
    }
}


// MARK: - EXTERNAL FUNCTIONS
extension notificationAskVC{
    @objc func switchActEmail(_ sender: UISwitch){
        notificationAskVM.emailNotified = sender.isOn ? 1 : 0
        btnRight.isHidden = false
    }
    
    @objc func switchActPush(_ sender: UISwitch){
        notificationAskVM.pushNotified = sender.isOn ? 1 : 0
        btnRight.isHidden = false
    }
    
    @objc func switchActSMS(_ sender: UISwitch){
        notificationAskVM.smsNotified = sender.isOn ? 1 : 0
        btnRight.isHidden = false
    }
    
    @objc func btnActSave(_ sender: UIButton){
        btnRight.isHidden = true
        notificationAskVM.saveNotificationAPI()
    }
}
