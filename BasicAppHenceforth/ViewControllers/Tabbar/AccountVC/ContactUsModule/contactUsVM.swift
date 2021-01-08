//
//  contactUsVM.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 08/01/21.
//

import UIKit

class ContactUsVM {
    
    var controller : contactUsVC?

    class var shared: ContactUsVM {
        struct Static {
            static let instance = ContactUsVM()
        }
        return Static.instance
    }

    func checkValidations(){
        if controller == nil{
            return
        }
        
        if controller!.tfName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            controller?.tfName.shake()
            CommonFunctions.toster(L10n.PleaseEnterName.description)
            CommonFunctions.errorSkyTF(controller!.tfName,
                                       img: Asset.user.image(),
                                       placeHolder: L10n.Name.description)
        } else if controller!.tfEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            controller?.tfEmail.shake()
            CommonFunctions.toster(L10n.PleaseEnterEmail.description)
            CommonFunctions.errorSkyTF(controller!.tfEmail,
                                       img: Asset.email.image(),
                                       placeHolder: L10n.Email.description)
        } else if !CommonFunctions.isValidEmail(controller!.tfEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)){
            controller?.tfEmail.shake()
            CommonFunctions.toster(L10n.PleaseEnterValidEmail.description)
            CommonFunctions.errorSkyTF(controller!.tfEmail,
                                       img: Asset.email.image(),
                                       placeHolder: L10n.Email.description)
        } else if controller!.tfPhoneNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            controller?.tfPhoneNumber.shake()
            controller?.phoneNumberIsError(true)
            CommonFunctions.toster(L10n.PleaseEnterPhoneNumber.description)
            CommonFunctions.errorSkyTF(controller!.tfPhoneNumber,
                                       img: Asset.ic_phone_number.image(),
                                       placeHolder: "              \(L10n.PhoneNumber.description)")
        }  else if controller!.tvMsg.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            controller?.tvMsg.superview!.shake()
            CommonFunctions.toster(L10n.PleaseEnterMessage.description)
            
            controller!.vwMsg.backgroundColor = UIColor.errorColor
            controller!.tvMsg.textColor = UIColor.errorColor
            controller!.tvMsg.tintColor = UIColor.errorColor
            controller!.lblMsg.textColor = UIColor.errorColor
            
        } else{
            self.contactUsAPI()
        }
    }
    
    func contactUsAPI(){
        
        let params : [String: AnyObject] = [
            "email" : self.controller!.tfEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject,
            "first_name" : self.controller!.tfName.text?.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject,
            "last_name" : self.controller!.tfName.text?.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject,
            "phone_number" : self.controller!.tfPhoneNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject,
            "country_code" : self.controller!.countryCode.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject,
            "message" : self.controller!.tvMsg.text?.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject
        ]
        
        self.controller?.btnSubmit.showLoading()
        self.controller?.view.isUserInteractionEnabled = false
        
        ApiHandler.callApiWithParameters(url: appConstantURL().contactUsURL, withParameters: params, ofType: MessageAPI.self, success2: { (response) in
            print(response)
            
            self.controller?.btnSubmit.hideLoading()
            self.controller?.view.isUserInteractionEnabled = true
            
            self.controller!.tfName.text = ""
            self.controller!.tfEmail.text = ""
            self.controller!.tfPhoneNumber.text = ""
            self.controller!.tvMsg.text = ""
            
            CommonFunctions.toster(response.message ?? "")
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.controller!.navigationController?.popViewController(animated: true)
            }

        }, failure: { (reload, error) in
            self.controller?.btnSubmit.hideLoading()
            self.controller?.view.isUserInteractionEnabled = true
            if reload{
                self.contactUsAPI()
            }
        }, method: .PostWithJSON, img: nil, imageParamater: "", headerPresent: true)
    }
}
