//
//  notificationVM.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 08/01/21.
//

import Foundation

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
        
    }    
}
