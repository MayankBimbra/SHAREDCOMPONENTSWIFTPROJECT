//
//  changePasswordVM.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 08/01/21.
//

import Foundation

class ChangePasswordVM {

    var controller : changePasswordVC?

    class var shared: ChangePasswordVM {
        struct Static {
            static let instance = ChangePasswordVM()
        }
        return Static.instance
    }

    func checkValidations(){
        if controller == nil{
            return
        }
        
        if controller!.tfNewPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            controller?.tfNewPassword.shake()
            CommonFunctions.toster(L10n.PleaseEnterOldPassword.description)
            CommonFunctions.errorSkyTFBtn(controller!.tfNewPassword, btn: controller!.btneye1, placeHolder: L10n.OldPassword.description)
        } else if controller!.tfConfirmPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            controller?.tfConfirmPassword.shake()
            CommonFunctions.toster(L10n.PleaseEnterNewPassword.description)
            CommonFunctions.errorSkyTFBtn(controller!.tfConfirmPassword, btn: controller!.btneye2, placeHolder: L10n.NewPassword.description)
        } else if !CommonFunctions.isValidPassword(controller!.tfConfirmPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)){
            controller?.tfConfirmPassword.shake()
            CommonFunctions.toster(L10n.PleaseEnterValidPassword.description)
            CommonFunctions.errorSkyTFBtn(controller!.tfConfirmPassword, btn: controller!.btneye2, placeHolder: L10n.NewPassword.description)
        }else{
            self.changePasswordAPI()
        }
    }

    func changePasswordAPI(){
        
        let params : [String: AnyObject] = [
            "old_password" : controller!.tfNewPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject,
            "new_password" : controller!.tfConfirmPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject
        ]
        
        self.controller!.btnUpdatePassword.showLoading()
        self.controller!.view.isUserInteractionEnabled = false
        
        ApiHandler.callApiWithParameters(url: appConstantURL().changePassowrdURL, withParameters: params, ofType: MessageAPI.self, success2: { (response) in
            print(response)
            self.controller!.btnUpdatePassword.hideLoading()
            self.controller!.view.isUserInteractionEnabled = true

            CommonFunctions.toster(response.message ?? "")
            
            self.controller!.tfNewPassword.text = ""
            self.controller!.tfConfirmPassword.text = ""

            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.controller!.navigationController?.popViewController(animated: true)
            }
            
        }, failure: { (reload, error) in
            self.controller!.btnUpdatePassword.hideLoading()
            self.controller!.view.isUserInteractionEnabled = true

            print(error)
            if reload{
                self.changePasswordAPI()
            }
        }, method: .PUTWithJSON, img: nil, imageParamater: "", headerPresent: true)
    }
}
