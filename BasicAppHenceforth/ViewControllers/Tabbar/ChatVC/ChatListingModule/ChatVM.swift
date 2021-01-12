//
//  ChatVM.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 09/01/21.
//

import UIKit
import ESPullToRefresh

class ChatVM {
    
    var controller : chatVC?
    
    var pageNumber : Int = 1
    var apiHitOnce = false
    var apiHitting : Bool = false
    var canPaginate : Bool = true


    class var shared: ChatVM {
        struct Static {
            static let instance = ChatVM()
        }
        return Static.instance
    }
    
    func fetchChatAPI(){
        
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
        
        ApiHandler.callApiWithParameters(url: appConstantURL().chatListingAPI, withParameters: params, ofType: ChatAPI.self, success2: { (response) in
            print(response)
            self.apiHitOnce = true
            self.apiHitting = false
            CommonFunctions.hideLoader()
            if self.pageNumber == 1{
                self.controller!.chatData = response
            }else{
                self.controller!.chatData.append(contentsOf: response)
            }
            self.controller!.tblView.es.stopPullToRefresh()
            self.controller!.tblView.es.stopLoadingMore()
            self.canPaginate = response.count == 10 ? true : false
            self.controller!.tblView.reloadData()
        }, failure: { (reload, error) in
            CommonFunctions.hideLoader()
            self.apiHitting = false
            self.controller!.tblView.es.stopPullToRefresh()
            self.controller!.tblView.es.stopLoadingMore()
            if reload{
                self.fetchChatAPI()
            }else{
                print(error)
            }
        }, method: .GET, img: nil, imageParamater: "", headerPresent: true)
        
    }
}
