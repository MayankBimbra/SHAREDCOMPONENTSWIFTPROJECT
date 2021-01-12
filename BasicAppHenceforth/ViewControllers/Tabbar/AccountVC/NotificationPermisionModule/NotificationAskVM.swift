//
//  NotificationAskVM.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 09/01/21.
//

import Foundation

class NotificationAskVM {
    
    var controller : notificationAskVC?
    var emailNotified : Int!
    var pushNotified : Int!
    var smsNotified : Int!

    class var shared: NotificationAskVM {
        struct Static {
            static let instance = NotificationAskVM()
        }
        return Static.instance
    }
    
    func saveNotificationAPI(){
        if controller == nil{
            return
        }
        
        let params : [String : AnyObject] = [
            "is_email_notified" : emailNotified as AnyObject,
            "is_push_notified" : pushNotified as AnyObject,
            "is_sms_notified" : smsNotified as AnyObject
        ]
        
        CommonFunctions.showLoader()
        
        ApiHandler.callApiWithParameters(url: appConstantURL().resetNotificationsURL, withParameters: params, ofType: MessageAPI.self, success2: { (response) in
            print(response)
            CommonFunctions.toster(response.message ?? "")
            CommonFunctions.hideLoader()
            userData.shared.isEmailNotified = self.emailNotified
            userData.shared.isPushNotified = self.pushNotified
            userData.shared.isSMSNotified = self.smsNotified
            userData.shared.dataSave()
        }, failure: { (reload, error) in
            CommonFunctions.hideLoader()
            print(error)
            if reload{
                self.saveNotificationAPI()
            }
        }, method: .PostWithJSON, img: nil, imageParamater: "", headerPresent: true)
    }
}
