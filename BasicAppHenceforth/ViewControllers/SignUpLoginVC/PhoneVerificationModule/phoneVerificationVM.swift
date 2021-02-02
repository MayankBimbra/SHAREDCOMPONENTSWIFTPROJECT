//
//  phoneVerificationVM.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 06/01/21.
//

import UIKit

class phoneVerificationVM {
    
    var controller : phoneVerificationVC?
    var timer : Timer!
    var counter = 30
    
    class var shared: phoneVerificationVM {
        struct Static {
            static let instance = phoneVerificationVM()
        }
        return Static.instance
    }

    func resendCodeAPI(){
        if controller == nil{
            return
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        timerAction(timer)
        ApiHandler.callApiWithParameters(url: appConstantURL().resendPhoneVerifyURL, withParameters: [:], ofType: MessageAPI.self, success2: { (response) in
            CommonFunctions.toster(response.message ?? "")
        }, failure: { (reload, error) in
            if reload{
                self.resendCodeAPI()
            }else{
                CommonFunctions.toster(error)
            }
        }, method: .POST, img: nil, imageParamater: "", headerPresent: true)
    }
    
    @objc func timerAction(_ timer: Timer) {
        var showCounter = "\(counter)"
        if counter < 10{
            showCounter = "0\(counter)"
        }
        if counter > 0{
            self.controller!.lblDidntReceiveCode.attributedText = CommonFunctions.sendAttText([L10n.DidntReceiveCode.description, "00:\(showCounter)"], fonts: [UIFont.MontserratMedium(Size.Medium.sizeValue()), UIFont.MontserratMedium(Size.Medium.sizeValue())], color: [UIColor.textColorOne, UIColor.themeColor], alingment: .left, spacing: 4)
            counter -= 1
        }else{
            timer.invalidate()
            counter = 30
            self.controller?.makingSendAgainLabel()
        }
    }
    
    func checkVerificationOTP(){
        if controller == nil{
            return
        }
        
        if controller?.tf1.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || controller?.tf2.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || controller?.tf3.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || controller?.tf4.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || controller?.tf5.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || controller?.tf6.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            CommonFunctions.toster(L10n.PleaseEnterOTP.description)
            controller?.tf1.shake()
            controller?.tf2.shake()
            controller?.tf3.shake()
            controller?.tf4.shake()
            controller?.tf5.shake()
            controller?.tf6.shake()
            
            controller?.tf1.layer.borderWidth = 1
            controller?.tf1.layer.borderColor = UIColor.errorColor.cgColor
            
            controller?.tf2.layer.borderWidth = 1
            controller?.tf2.layer.borderColor = UIColor.errorColor.cgColor
            
            controller?.tf3.layer.borderWidth = 1
            controller?.tf3.layer.borderColor = UIColor.errorColor.cgColor
            
            controller?.tf4.layer.borderWidth = 1
            controller?.tf4.layer.borderColor = UIColor.errorColor.cgColor
            
            controller?.tf5.layer.borderWidth = 1
            controller?.tf5.layer.borderColor = UIColor.errorColor.cgColor
            
            controller?.tf6.layer.borderWidth = 1
            controller?.tf6.layer.borderColor = UIColor.errorColor.cgColor
            
        }else{
            otpVerificationAPI()
        }
    }
    
    func otpVerificationAPI(){
        self.controller?.view.endEditing(true)
        let params : [String: AnyObject] = [
            "code" : "\(self.controller!.tf1.text!.trimmingCharacters(in: .whitespacesAndNewlines))\(self.controller!.tf2.text!.trimmingCharacters(in: .whitespacesAndNewlines))\(self.controller!.tf3.text!.trimmingCharacters(in: .whitespacesAndNewlines))\(self.controller!.tf4.text!.trimmingCharacters(in: .whitespacesAndNewlines))\(self.controller!.tf5.text!.trimmingCharacters(in: .whitespacesAndNewlines))\(self.controller!.tf6.text!.trimmingCharacters(in: .whitespacesAndNewlines))" as AnyObject
        ]
        self.controller!.view.isUserInteractionEnabled = false
        self.controller!.btnNext.showLoading()
        ApiHandler.callApiWithParameters(url: appConstantURL().verifyPhoneURL, withParameters: params, ofType: MessageAPI.self, success2: { (response) in
            print(response)
            self.controller!.view.isUserInteractionEnabled = true
            self.controller!.btnNext.hideLoading()
            userData.shared.isPhoneVerified = 1
            userData.shared.dataSave()
            let vc = phoneVerifySuccessVC.instantiateFromAppStoryboard(appStoryboard: .Main)
            vc.fromEditProfile = self.controller!.fromEditProfile
            self.controller!.navigationController?.pushViewController(vc, animated: false)
        }, failure: { (reload, error) in
            self.controller!.view.isUserInteractionEnabled = true
            self.controller!.btnNext.hideLoading()
            if reload{
                self.otpVerificationAPI()
            }else{
                CommonFunctions.toster(error)
            }
        }, method: .POST, img: nil, imageParamater: "", headerPresent: true)
    }
}
