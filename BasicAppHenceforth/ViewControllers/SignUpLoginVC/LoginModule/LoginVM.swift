//
//  LoginVM.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 06/01/21.
//

import UIKit

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

class SocialVM {
    
    var controller : UIViewController?

    class var shared: SocialVM {
        struct Static {
            static let instance = SocialVM()
        }
        return Static.instance
    }
    
    func socialLoginAPI( fbId: String?, googleID: String?, appleID: String?, firstName: String?, lastName: String?, email: String?, response2: @escaping ()->()){
        
        var params : [String: AnyObject] = [
            "fcm_id" : deviceInfo.fcmId as AnyObject,
            "device_id" : deviceInfo.deviceId as AnyObject,
            "device_type" : deviceInfo.deviceType as AnyObject
        ]
        
        if firstName != nil{
            params["first_name"] = firstName! as AnyObject
        }

        if lastName != nil{
            params["last_name"] = lastName! as AnyObject
        }

        if email != nil{
            params["email"] = email! as AnyObject
        }
        
        if fbId != nil{
            params["fb_id"] = fbId! as AnyObject
        }

        if googleID != nil{
            params["google_id"] = googleID! as AnyObject
        }

        if appleID != nil{
            params["apple_id"] = appleID! as AnyObject
        }
        
        ApiHandler.callApiWithParameters(url: appConstantURL().loginURL, withParameters: params, ofType: SignUpAPI.self, success2: { (response) in
            userData.shared.fromSignUpData(response)
            response2()
            if response.user?.isPhoneVerified == 0{
                let vc = phoneVerificationVC.instantiateFromAppStoryboard(appStoryboard: AppStoryboard.Main)
                self.controller!.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = tabbarVC.instantiateFromAppStoryboard(appStoryboard: .Tabbar)
                self.controller!.navigationController?.pushViewController(vc, animated: true)
            }
        }, failure: { (reload, error) in
            if reload{
                self.socialLoginAPI(fbId: fbId, googleID: googleID, appleID: appleID, firstName: firstName, lastName: lastName, email: email) {
                    response2()
                }
            }
            response2()
        }, method: .PostWithJSON, img: nil, imageParamater: "", headerPresent: false)
    }
}
