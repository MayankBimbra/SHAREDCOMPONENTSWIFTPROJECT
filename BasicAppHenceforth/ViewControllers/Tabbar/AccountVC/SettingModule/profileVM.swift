//
//  profileVM.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 06/01/21.
//

import Foundation

class ProfileVM {
    
    var controller : profileVC?
    
    class var shared: ProfileVM {
        struct Static {
            static let instance = ProfileVM()
        }
        return Static.instance
    }

    func logoutAPI(){
        let params : [String : AnyObject] = [
            "device_id" : deviceInfo.deviceId as AnyObject
        ]
        ApiHandler.callApiWithParameters(url: appConstantURL().logoutURL, withParameters: params, ofType: MessageAPI.self, success2: { (response) in
            print(response)
        }, failure: { (reload, error) in
            print(error)
//            if reload{
//
//            }else{
//                print(error)
//            }
        }, method: .DELETEWithJSON, img: nil, imageParamater: "", headerPresent: true)
    }
}
