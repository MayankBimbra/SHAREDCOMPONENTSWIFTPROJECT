//
//  ForgotPasswordVM.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 06/01/21.
//

import UIKit

class ForgotPasswordVM {
    
    var controller : ForgotPasswordVC?
    
    class var shared: ForgotPasswordVM {
        struct Static {
            static let instance = ForgotPasswordVM()
        }
        return Static.instance
    }

    func checkVerificationEmail(){
        
        if controller == nil{
            return
        }
        
        if controller?.tfEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            CommonFunctions.toster(L10n.PleaseEnterEmail.description)
            controller?.tfEmail.shake()
            CommonFunctions.errorSkyTF(controller!.tfEmail,
                                       img: Asset.email.image(),
                                       placeHolder: L10n.Email.description)
        }else{
            forgotPasswordAPI()
        }
    }
    
    func forgotPasswordAPI(){
        self.controller?.view.endEditing(true)
        let params : [String : AnyObject] = [
            "email" : controller!.tfEmail!.text?.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject
        ]
        self.controller?.view.isUserInteractionEnabled = false
        self.controller?.btnSubmit.showLoading()
        ApiHandler.callApiWithParameters(url: appConstantURL().forgotURL, withParameters: params, ofType: MessageAPI.self, success2: { (response) in
            print(response)
            self.controller?.view.isUserInteractionEnabled = true
            self.controller?.btnSubmit.hideLoading()
            CommonFunctions.toster(response.message ?? "")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                self.controller?.navigationController?.popViewController(animated: true)
            }
        }, failure: { (reload, error) in
            self.controller?.view.isUserInteractionEnabled = true
            self.controller?.btnSubmit.hideLoading()
            if reload{
                self.forgotPasswordAPI()
            }else{
                CommonFunctions.toster(error)
            }
        }, method: .POST, img: nil, imageParamater: "", headerPresent: false)
    }
}
