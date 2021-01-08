//
//  LoginVM.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 06/01/21.
//

import Foundation

class LoginVM {
    
    var controller : LoginVC?

    class var shared: LoginVM {
        struct Static {
            static let instance = LoginVM()
        }
        return Static.instance
    }

    func checkLoginValidations(){
        if controller == nil{
            return
        }
        
        if controller?.tfEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            controller?.tfEmail.shake()
            CommonFunctions.toster(L10n.PleaseEnterEmail.description)
            CommonFunctions.errorSkyTF(controller!.tfEmail,
                                       img: Asset.email.image(),
                                       placeHolder: L10n.Email.description)
        }else if controller?.tfPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            controller?.tfPassword.shake()
            CommonFunctions.toster(L10n.PleaseEnterPassword.description)
            CommonFunctions.errorSkyTFBtn(controller!.tfPassword,
                                          btn: controller!.btneye,
                                          placeHolder: L10n.Password.description)
        }else{
            loginAPI()
        }
    }
    
    func loginAPI(){
        self.controller?.view.endEditing(true)
        let params : [String : AnyObject] = [
            "email" : controller!.tfEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject,
            "password" : controller!.tfPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject,
            "fcm_id" : deviceInfo.fcmId as AnyObject,
            "device_id" : deviceInfo.deviceId as AnyObject,
            "device_type" : deviceInfo.deviceType as AnyObject,
        ]
        
        controller?.view.isUserInteractionEnabled = false
        controller?.btnLogin.showLoading()

        ApiHandler.callApiWithParameters(url: appConstantURL().loginURL, withParameters: params, ofType: SignUpAPI.self, success2: { (response) in
            print(response)
            self.controller?.view.isUserInteractionEnabled = true
            self.controller?.btnLogin.hideLoading()
            userData.shared.fromSignUpData(response)
            if response.user?.isPhoneVerified == 0{
                let vc = phoneVerificationVC.instantiateFromAppStoryboard(appStoryboard: AppStoryboard.Main)
                self.controller!.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = tabbarVC.instantiateFromAppStoryboard(appStoryboard: .Tabbar)
                self.controller!.navigationController?.pushViewController(vc, animated: true)
            }
            self.controller?.tfEmail.text = ""
            self.controller?.tfPassword.text = ""
        }, failure: { (reload, error) in
            self.controller?.view.isUserInteractionEnabled = true
            self.controller?.btnLogin.hideLoading()
            if reload{
                self.loginAPI()
            }else{
                CommonFunctions.toster(error)
            }
        }, method: .PostWithJSON, img: nil, imageParamater: "", headerPresent: false)
    }
}
