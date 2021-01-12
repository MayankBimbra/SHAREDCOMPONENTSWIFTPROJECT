//
//  profileInnerVM.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 06/01/21.
//

import UIKit

class ProfileInnerVM {
    
    var controller : profileInnerVC?

    class var shared: ProfileInnerVM {
        struct Static {
            static let instance = ProfileInnerVM()
        }
        return Static.instance
    }
    
    func setUIData(){
        if controller == nil{
            return
        }
        
        self.controller!.lblNameJoining.attributedText = CommonFunctions.sendAttText(["\(L10n.HiText.description)\(userData.shared.firstName)", "\n\(L10n.JoinedText.description)October, 2020"], fonts: [UIFont.MontserratMedium(Size.XXXLarge.sizeValue()), UIFont.MontserratMedium(Size.Medium.sizeValue())], color: [UIColor.black, UIColor.textColorOne], alingment: .left, spacing: 4)
        if userData.shared.userDescription == ""{
            self.controller!.lblAboutDesc.attributedText = CommonFunctions.sendAttText([L10n.NA.description], fonts: [UIFont.MontserratMedium(Size.Medium.sizeValue())], color: [UIColor.textColorOne], alingment: .left, spacing: 4)
        }else{
            self.controller!.lblAboutDesc.attributedText = CommonFunctions.sendAttText([userData.shared.userDescription], fonts: [UIFont.MontserratMedium(Size.Medium.sizeValue())], color: [UIColor.textColorOne], alingment: .left, spacing: 4)
        }
        self.controller!.lblEmailVerified.attributedText = CommonFunctions.sendAttText([userData.shared.email], fonts: [UIFont.MontserratMedium(Size.Medium.sizeValue())], color: [UIColor.appBlackColor], alingment: .left, spacing: 4)
        self.controller!.lblPhoneNumVerified.attributedText = CommonFunctions.sendAttText(["\(userData.shared.countryCode)\(userData.shared.phoneNumber)"], fonts: [UIFont.MontserratMedium(Size.Medium.sizeValue())], color: [UIColor.appBlackColor], alingment: .left, spacing: 4)
        if userData.shared.designation == ""{
            self.controller!.lblBusinessVerified.attributedText = CommonFunctions.sendAttText([L10n.NA.description], fonts: [UIFont.MontserratMedium(Size.Medium.sizeValue())], color: [UIColor.appBlackColor], alingment: .left, spacing: 4)
        }else{
            self.controller!.lblBusinessVerified.attributedText = CommonFunctions.sendAttText([userData.shared.designation], fonts: [UIFont.MontserratMedium(Size.Medium.sizeValue())], color: [UIColor.appBlackColor], alingment: .left, spacing: 4)
        }

        controller?.imgViewEmailVerified.isHidden = (userData.shared.isEmailVerified == 1) ? false : true
        controller?.imgViewPhoneVerified.isHidden = (userData.shared.isPhoneVerified == 1) ? false : true

        controller?.imgViewDP.yy_setImage(with: URL(string: CommonFunctions.getImage(userData.shared.profileImage, quality: .medium)), placeholder: nil)
    }
    
    func getProfileAPI(){
        ApiHandler.callApiWithParameters(url: appConstantURL().getProfileURL, withParameters: [:], ofType: User.self, success2: { (response) in
            print(response)
            
            userData.shared.fromProfileData(response)
            self.setUIData()
        }, failure: { (reload, error) in
            print(error)
        }, method: .GET, img: nil, imageParamater: "", headerPresent: true)
    }
}
