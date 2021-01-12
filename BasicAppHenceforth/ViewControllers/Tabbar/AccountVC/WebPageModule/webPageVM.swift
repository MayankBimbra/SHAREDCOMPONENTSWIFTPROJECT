//
//  webPageVM.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 09/01/21.
//

import Foundation

class WebPageVM {
    
    var controller : webPageVC?
    var emailNotified : Int!

    class var shared: WebPageVM {
        struct Static {
            static let instance = WebPageVM()
        }
        return Static.instance
    }
    
    
    func getContentDataAPI(){
        if controller == nil{
            return
        }
        
        var pageNum = 0
        
        if controller!.screenType == .AboutUs{
            pageNum = 1
        }else if controller!.screenType == .TermsAndCond{
            pageNum = 2
        }else if controller!.screenType == .PrivacyPolicy{
            pageNum = 3
        }
        
        CommonFunctions.showLoader()
        let params : [String: AnyObject] = [
            "id" : pageNum as AnyObject
        ]
        ApiHandler.callApiWithParameters(url: appConstantURL().contentDataURL, withParameters: params, ofType: ContentAPI.self, success2: { (response) in
            print(response)
            CommonFunctions.hideLoader()
            self.controller!.lblHeader.text = response.title
            self.controller!.lblData.attributedText = response.content?.htmlToAttributedString
            self.controller!.lblData.isHidden = false
            if response.image == nil{
                self.controller!.viewImage.isHidden = true
            }else{
                self.controller!.viewImage.isHidden = false
                self.controller!.imgView.yy_setImage(with: URL(string: CommonFunctions.getImage(response.image!, quality: .large)), placeholder: nil)
            }
        }, failure: { (reload, error) in
            CommonFunctions.hideLoader()
            if reload{
                self.getContentDataAPI()
            }else{
                print(error)
            }
        }, method: .GET, img: nil, imageParamater: "", headerPresent: true)
    }
}
