//
//  notificationVM.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 08/01/21.
//

import UIKit
import ESPullToRefresh

class NotificationVM {
    
    var controller : notificationVC?
    
    var pageNumber : Int = 1
    var apiHitOnce = false
    var apiHitting : Bool = false
    var canPaginate : Bool = true


    class var shared: NotificationVM {
        struct Static {
            static let instance = NotificationVM()
        }
        return Static.instance
    }
    
    func fetchNotificationAPI(){
        
        if controller == nil{
            return
        }
        
        let params : [String: AnyObject] = [
            "limit" : 10 as AnyObject,
            "page" : pageNumber as AnyObject
        ]
        
        if !apiHitOnce{
            CommonFunctions.showLoader()
        }
        
        self.apiHitting = true
        
        ApiHandler.callApiWithParameters(url: appConstantURL().notificationAPI, withParameters: params, ofType: NotificationAPI.self, success2: { (response) in
            print(response)
            self.apiHitOnce = true
            self.apiHitting = false
            CommonFunctions.hideLoader()
            if self.pageNumber == 1{
                self.controller!.notificationData = response.notifications ?? []
            }else{
                self.controller!.notificationData.append(contentsOf: response.notifications ?? [])
            }
            self.controller!.tblView.es.stopPullToRefresh()
            self.controller!.tblView.es.stopLoadingMore()
            self.canPaginate = (response.notifications ?? []).count == 10 ? true : false
            self.controller!.tblView.reloadData()
        }, failure: { (reload, error) in
            CommonFunctions.hideLoader()
            self.apiHitting = false
            self.controller!.tblView.es.stopPullToRefresh()
            self.controller!.tblView.es.stopLoadingMore()
            if reload{
                self.fetchNotificationAPI()
            }else{
                print(error)
            }
        }, method: .GET, img: nil, imageParamater: "", headerPresent: true)
        
    }    
}
