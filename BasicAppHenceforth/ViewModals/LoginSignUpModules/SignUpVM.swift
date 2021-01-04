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
        
        if controller?.tfFirstName.text == ""{
            controller?.tfFirstName.shake()
            CommonFunctions.toster(L10n.PleaseEnterFirstName.description)
            CommonFunctions.errorSkyTF(controller!.tfFirstName,
                                       img: Asset.user.image(),
                                       placeHolder: L10n.FirstName.description)
        }else if controller?.tfLastName.text == ""{
            controller?.tfLastName.shake()
            CommonFunctions.errorSkyTF(controller!.tfLastName,
                                       img: Asset.user.image(),
                                       placeHolder: L10n.LastName.description)
            CommonFunctions.toster(L10n.PleaseEnterLastName.description)
        }else if controller?.tfEmail.text == ""{
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
        }else if controller?.tfPassword.text == ""{
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
        }else if controller?.tfConfirmPassword.text == ""{
            controller?.tfConfirmPassword.shake()
            CommonFunctions.toster(L10n.PleaseEnterConfirmPassword.description)
            CommonFunctions.errorSkyTFBtn(controller!.tfConfirmPassword,
                                          btn: controller!.btnEye2,
                                          placeHolder: L10n.ConfirmPassword.description)
        }else if controller?.tfConfirmPassword.text != controller?.tfPassword.text{
            controller?.tfConfirmPassword.shake()
            controller?.tfPassword.shake()
            CommonFunctions.toster(L10n.PleaseEnterSamePassword.description)
        }else if controller?.tfPhoneNumber.text == ""{
            controller?.tfPhoneNumber.shake()
            controller?.phoneNumberIsError(true)
            CommonFunctions.toster(L10n.PleaseEnterPhoneNumber.description)
            CommonFunctions.errorSkyTF(controller!.tfPhoneNumber,
                                       img: Asset.ic_phone_number.image(),
                                       placeHolder: "             \(L10n.PhoneNumber.description)")
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
        
    }
}
