//
//  SignUpVM.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 03/01/21.
//

import Foundation

class SignUpVM {
    
    var controller : SignUpVC?
    
    class var shared: SignUpVM {
        struct Static {
            static let instance = SignUpVM()
        }
        return Static.instance
    }
    
    func signUpChk(){
        
        if controller == nil{
            return
        }
        
        if controller?.tfFirstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            controller?.tfFirstName.shake()
            CommonFunctions.toster(L10n.PleaseEnterFirstName.description)
            CommonFunctions.errorSkyTF(controller!.tfFirstName,
                                       img: Asset.user.image(),
                                       placeHolder: L10n.FirstName.description)
        }else if controller?.tfLastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            controller?.tfLastName.shake()
            CommonFunctions.errorSkyTF(controller!.tfLastName,
                                       img: Asset.user.image(),
                                       placeHolder: L10n.LastName.description)
            CommonFunctions.toster(L10n.PleaseEnterLastName.description)
        }else if controller?.tfEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            controller?.tfEmail.shake()
            CommonFunctions.errorSkyTF(controller!.tfEmail,
                                       img: Asset.email.image(),
                                       placeHolder: L10n.Email.description)
            CommonFunctions.toster(L10n.PleaseEnterEmail.description)
        }else if !CommonFunctions.isValidEmail((controller?.tfEmail.text)!){
            controller?.tfEmail.shake()
            CommonFunctions.errorSkyTF(controller!.tfEmail,
                                       img: Asset.email.image(),
                                       placeHolder: L10n.Email.description)
            CommonFunctions.toster(L10n.PleaseEnterValidEmail.description)
        }else if controller?.tfPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            controller?.tfPassword.shake()
            CommonFunctions.toster(L10n.PleaseEnterPassword.description)
            CommonFunctions.errorSkyTFBtn(controller!.tfPassword,
                                          btn: controller!.btnEye1,
                                          placeHolder: L10n.Password.description)
        }else if !CommonFunctions.isValidPassword((controller?.tfPassword.text)!){
            controller?.tfPassword.shake()
            CommonFunctions.toster(L10n.PleaseEnterValidPassword.description)
            CommonFunctions.errorSkyTFBtn(controller!.tfPassword,
                                          btn: controller!.btnEye1,
                                          placeHolder: L10n.Password.description)
        }else if controller?.tfConfirmPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            controller?.tfConfirmPassword.shake()
            CommonFunctions.toster(L10n.PleaseEnterConfirmPassword.description)
            CommonFunctions.errorSkyTFBtn(controller!.tfConfirmPassword,
                                          btn: controller!.btnEye2,
                                          placeHolder: L10n.ConfirmPassword.description)
        }else if controller?.tfConfirmPassword.text != controller?.tfPassword.text{
            controller?.tfConfirmPassword.shake()
            controller?.tfPassword.shake()
            CommonFunctions.toster(L10n.PleaseEnterSamePassword.description)
        }else if controller?.tfPhoneNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            controller?.tfPhoneNumber.shake()
            controller?.phoneNumberIsError(true)
            CommonFunctions.toster(L10n.PleaseEnterPhoneNumber.description)
            CommonFunctions.errorSkyTF(controller!.tfPhoneNumber,
                                       img: Asset.ic_phone_number.image(),
                                       placeHolder: "              \(L10n.PhoneNumber.description)")
//        }else if !CommonFunctions.isValidPhoneNumber((controller?.tfPhoneNumber.text)!){
//            controller?.tfPhoneNumber.shake()
//            CommonFunctions.toster(L10n.PleaseEnterValidPhoneNumber.description)
//            CommonFunctions.errorSkyTF(controller!.tfPhoneNumber,
//                                       img: Asset.ic_phone_number.image(),
//                                       placeHolder: "             \(L10n.PhoneNumber.description)")

        }else{
            signUpAccount()
        }
    }
    
    func signUpAccount(){
        let params : [String: AnyObject] = [
            "first_name" : controller!.tfFirstName.text!.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject,
            "last_name" : controller!.tfLastName.text!.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject,
            "email" : controller!.tfEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject,
            "password" : controller!.tfPassword.text! as AnyObject,
            "fcm_id" : deviceInfo.fcmId as AnyObject,
            "device_id" : deviceInfo.deviceId as AnyObject,
            "device_type" : deviceInfo.deviceType as AnyObject,
            "phone_no" : controller!.tfPhoneNumber.text!.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject,
            "country_code" : controller!.selectedValue as AnyObject,
        ]
        self.controller?.view.endEditing(true)
        controller?.view.isUserInteractionEnabled = false
        controller?.btnSignUp.showLoading()
        
        ApiHandler.callApiWithParameters(url: appConstantURL().signUpURL, withParameters: params, ofType: SignUpAPI.self, success2: { (response) in
            self.controller?.view.isUserInteractionEnabled = true
            self.controller?.btnSignUp.hideLoading()

            userData.shared.fromSignUpData(response)
            
            let vc = phoneVerificationVC.instantiateFromAppStoryboard(appStoryboard: AppStoryboard.Main)
            self.controller!.navigationController?.pushViewController(vc, animated: true)
            
            self.controller?.tfFirstName.text = ""
            self.controller?.tfLastName.text = ""
            self.controller?.tfEmail.text = ""
            self.controller?.tfPassword.text = ""
            self.controller?.tfConfirmPassword.text = ""
            self.controller?.tfPhoneNumber.text = ""

            print(response)
        }, failure: { (reload, error) in
            self.controller?.view.isUserInteractionEnabled = true
            self.controller?.btnSignUp.hideLoading()
            if reload{
                self.signUpAccount()
            }else{
                print(error)
            }
        }, method: .POST, img: nil, imageParamater: "", headerPresent: false)
    }
}
