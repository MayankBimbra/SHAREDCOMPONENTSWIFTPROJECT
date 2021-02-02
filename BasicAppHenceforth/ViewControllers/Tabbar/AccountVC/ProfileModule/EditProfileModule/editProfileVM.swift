//
//  editProfileVM.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 06/01/21.
//

import UIKit

class EditProfileVM {
    
    var controller : editProfileVC?

    class var shared: EditProfileVM {
        struct Static {
            static let instance = EditProfileVM()
        }
        return Static.instance
    }
    
    func setData(){
        if controller == nil{
            return
        }
        
        controller!.tfFirstName.text = userData.shared.firstName
        controller!.tfLastName.text = userData.shared.lastName
        controller!.tfEmail.text = userData.shared.email
        controller!.tfPhoneNumber.text = "\(userData.shared.phoneNumber)"
        controller!.countryCode = userData.shared.countryCode
        controller!.btnPhoneNumber.setTitle(userData.shared.countryCode, for: .normal)
        controller!.tfWork.text = userData.shared.designation
        controller!.tvAbout.text = userData.shared.userDescription
        
        controller!.imgViewDP.yy_setImage(with: URL(string: CommonFunctions.getImage(userData.shared.profileImage, quality: .medium)), placeholder: nil)
        
        controller!.lblAbout.textColor = UIColor.textColorPlaceholder
        controller!.vwAbout.backgroundColor = UIColor.textColorPlaceholder
        controller!.lblAbout.text = L10n.AboutText.description
        if userData.shared.userDescription == ""{
            controller!.constTopUpper.constant = 0
            controller!.lblAbout.font = UIFont.MontserratMedium(Size.Medium.sizeValue())
        }else{
            controller!.constTopUpper.constant = -20
            controller!.lblAbout.font = UIFont.MontserratMedium(Size.Small.sizeValue())
        }
        self.controller!.view.layoutIfNeeded()
    }
    
    func checkValidations(){
        if controller == nil{
            return
        }

        if controller!.tfFirstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            controller?.tfFirstName.shake()
            CommonFunctions.toster(L10n.PleaseEnterFirstName.description)
            CommonFunctions.errorSkyTF(controller!.tfFirstName,
                                       img: nil,
                                       placeHolder: L10n.FirstName.description)
        }else if controller!.tfLastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            controller?.tfLastName.shake()
            CommonFunctions.toster(L10n.PleaseEnterLastName.description)
            CommonFunctions.errorSkyTF(controller!.tfLastName,
                                       img: nil,
                                       placeHolder: L10n.LastName.description)
        }else if controller!.tfEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            controller?.tfEmail.shake()
            CommonFunctions.toster(L10n.PleaseEnterEmail.description)
            CommonFunctions.errorSkyTF(controller!.tfEmail,
                                       img: nil,
                                       placeHolder: L10n.Email.description)
        }else if !CommonFunctions.isValidEmail(controller!.tfEmail.text!){
            controller!.tfEmail.shake()
            CommonFunctions.errorSkyTF(controller!.tfEmail,
                                       img: nil,
                                       placeHolder: L10n.Email.description)
            CommonFunctions.toster(L10n.PleaseEnterValidEmail.description)
        }else if controller!.tfPhoneNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            controller!.tfPhoneNumber.shake()
            CommonFunctions.toster(L10n.PleaseEnterPhoneNumber.description)
            CommonFunctions.errorSkyTF(controller!.tfPhoneNumber,
                                       img: nil,
                                       placeHolder: "              \(L10n.PhoneNumber.description)")
            controller?.phoneNumberIsError(true)
        }else if controller!.tfWork.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            controller!.tfWork.shake()
            CommonFunctions.toster(L10n.PleaseEnterWork.description)
            CommonFunctions.errorSkyTF(controller!.tfWork,
                                       img: nil,
                                       placeHolder: L10n.Business.description)
        }else if controller!.tvAbout.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            controller?.tvAbout.shake()
            controller?.lblAbout.shake()
            controller?.vwAbout.shake()
            CommonFunctions.toster(L10n.PleaseEnterAboutYourself.description)
            controller!.vwAbout.backgroundColor = UIColor.errorColor
            controller!.tvAbout.textColor = UIColor.errorColor
            controller!.tvAbout.tintColor = UIColor.errorColor
            controller!.lblAbout.textColor = UIColor.errorColor
        }else{
            editProfileAPI()
        }
    }
    
    func editProfileAPI(){
        
        var params : [String : AnyObject] = [
            "first_name" : controller!.tfFirstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject,
            "last_name" : controller!.tfLastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject,
//            "email" : controller!.tfEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject,
//            "phone_number" : controller!.tfPhoneNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject,
//            "country_code" : controller!.countryCode.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject,
            "designation" : controller!.tfWork.text?.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject,
            "description" : controller!.tvAbout.text?.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject,
        ]
        
        if controller!.tfPhoneNumber.text! == "\(userData.shared.phoneNumber)" && controller!.countryCode == userData.shared.countryCode{
            
        }else{
            params["phone_number"] = controller!.tfPhoneNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject
            params["country_code"] = controller!.countryCode.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject
        }
        
        if controller!.tfEmail.text! != userData.shared.email{
            params["email"] = controller!.tfEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject
        }
        
        if controller?.uploadedPhotoURL != ""{
            params["profile_image"] = controller!.uploadedPhotoURL as AnyObject
        }else{
            params["profile_image"] = userData.shared.profileImage as AnyObject
        }
        
        CommonFunctions.showLoader()
        
        ApiHandler.callApiWithParameters(url: appConstantURL().editProfileURL, withParameters: params, ofType: MessageAPI.self, success2: { (response) in
            CommonFunctions.hideLoader()
            
            print(response)
            
            CommonFunctions.toster(response.message ?? "")
            
            userData.shared.firstName = self.controller!.tfFirstName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            userData.shared.lastName = self.controller!.tfLastName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            userData.shared.email = self.controller!.tfEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            userData.shared.phoneNumber = Int(self.controller!.tfPhoneNumber.text!.trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
            userData.shared.countryCode = self.controller!.countryCode.trimmingCharacters(in: .whitespacesAndNewlines)
            userData.shared.designation = self.controller!.tfWork.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            userData.shared.userDescription = self.controller!.tvAbout.text!.trimmingCharacters(in: .whitespacesAndNewlines)

            if self.controller!.uploadedPhotoURL != ""{
                userData.shared.profileImage = self.controller!.uploadedPhotoURL
            }
            
            userData.shared.dataSave()
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.controller!.navigationController?.popViewController(animated: true)
            }
            
        }, failure: { (reload, error) in
            CommonFunctions.hideLoader()
            if reload{
                self.editProfileAPI()
            }
            print(error)
        }, method: .PUTWithJSON, img: nil, imageParamater: "", headerPresent: true)
    }
    
    func uploadingPhoto(_ img: UIImage){
        if controller == nil{
            return
        }

        ApiHandler.callApiWithParameters(url: appConstantURL().uploadImageURL, withParameters: [:], ofType: MessageAPI.self, success2: { (response) in
            print(response)
            self.controller!.uploadedPhotoURL = response.filename ?? ""
        }, failure: { (reload, error) in
            if reload{
                self.uploadingPhoto(img)
            }
        }, method: .PostWithImage, img: img, imageParamater: "file", headerPresent: true)
    }
    
    func resendEmailVerify(){
        if controller == nil{
            return
        }
        
        ApiHandler.callApiWithParameters(url: appConstantURL().emailVerifyURL, withParameters: [:], ofType: MessageAPI.self, success2: { (response) in
            print(response)
            CommonFunctions.toster(response.message ?? "")
        }, failure: { (reload, error) in
            if reload{
                self.resendEmailVerify()
            }
        }, method: .POST, img: nil, imageParamater: "", headerPresent: true)
    }
    
    func resendCodeAPI(){
        if controller == nil{
            return
        }
        
        ApiHandler.callApiWithParameters(url: appConstantURL().resendPhoneVerifyURL, withParameters: [:], ofType: MessageAPI.self, success2: { (response) in
            CommonFunctions.toster(response.message ?? "")
        }, failure: { (reload, error) in
            if reload{
                self.resendCodeAPI()
            }
        }, method: .POST, img: nil, imageParamater: "", headerPresent: true)
    }
}
