//
//  phoneVerificationVC.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 21/12/20.
//

import UIKit
import ActiveLabel

class phoneVerificationVC: headerVC {

    // MARK: - UI COMPONENTS
    @IBOutlet weak var lblSubHeading: UILabel!
    @IBOutlet weak var tf1: otpTextField!
    @IBOutlet weak var tf2: otpTextField!
    @IBOutlet weak var tf3: otpTextField!
    @IBOutlet weak var tf4: otpTextField!
    @IBOutlet weak var tf5: otpTextField!
    @IBOutlet weak var tf6: otpTextField!
    @IBOutlet weak var lblDidntReceiveCode: ActiveLabel!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblWrongError: UILabel!
    
    
    
    // MARK: - VARAIBLES
    
    
    
    // MARK: - OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        isBackEnabled = true
        super.viewDidLoad()
        setUpUI()
    }
}


// MARK: - SET UP UI
extension phoneVerificationVC{
    func setUpUI(){
        lblHeader.text = L10n.PhoneNumberVerification.description
        
        lblSubHeading.attributedText = CommonFunctions.sendAttText([L10n.EnterCodeVerification.description, "+919876543210"], fonts: [UIFont.MontserratMedium(Size.Medium.sizeValue()), UIFont.MontserratSemiBold(Size.Medium.sizeValue())], color: [UIColor.textColorOne, UIColor.black], alingment: .left)
        
        let tfs : [otpTextField] = [tf1, tf2, tf3, tf4, tf5, tf6]
        for tf in tfs{
            tf.backgroundColor = UIColor.bGColor
            tf.layer.cornerRadius = 4
            tf.textAlignment = .center
            tf.tintColor = .textColorMain
            tf.textColor = .textColorMain
            tf.delegate = self
            tf.otpDelegate = self
        }
        
        let customType = ActiveType.custom(pattern: "\\\(L10n.SendAgain.description)\\b") //Regex that looks for "with"
        lblDidntReceiveCode.enabledTypes = [customType]
        lblDidntReceiveCode.text = L10n.DidntReceiveCode.description + L10n.SendAgain.description
        lblDidntReceiveCode.textColor = UIColor.textColorOne
        lblDidntReceiveCode.customColor[customType] = UIColor.themeColor
        lblDidntReceiveCode.customSelectedColor[customType] = UIColor.themeColor
        lblDidntReceiveCode.font = UIFont.MontserratMedium(Size.Medium.sizeValue())
            
        lblDidntReceiveCode.handleCustomTap(for: customType) { element in
            CommonFunctions.toster("Send Again")
            self.lblWrongError.isHidden = false
        }
        
        lblWrongError.text = L10n.EnterWrongOTP.description
        lblWrongError.font = UIFont.MontserratMedium(Size.Medium.sizeValue())
        lblWrongError.textColor = UIColor.errorColor
        
        CommonFunctions.setbuttonBoarder(4, [btnNext])
        btnNext.titleLabel?.font = UIFont.MontserratSemiBold(Size.Medium.sizeValue())
        btnNext.setTitle(L10n.SUBMIT.description, for: .normal)
        btnNext.setTitleColor(UIColor.appWhiteColor, for: .normal)
        btnNext.addTarget(self, action: #selector(btnActNext(_:)), for: .touchUpInside)

    }
}


// MARK: - DELEGATE FUNCTIONS
extension phoneVerificationVC: UITextFieldDelegate, MyTextFieldDelegate{
    func textFieldDidDelete(_ tf: UITextField) {
        switch tf {
        case tf1:
            tf1.resignFirstResponder()
        case tf2:
            tf1.becomeFirstResponder()
        case tf3:
            tf2.becomeFirstResponder()
        case tf4:
            tf3.becomeFirstResponder()
        case tf5:
            tf4.becomeFirstResponder()
        case tf6:
            tf5.becomeFirstResponder()
        default:
            print("error")
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if !string.isNumeric && string != ""{
            return false
        }
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        if newString.length >= 2{
            if string.count == 1{
                textField.text = string
                switch textField {
                case self.tf1:
                    self.tf2.becomeFirstResponder()
                case self.tf2:
                    self.tf3.becomeFirstResponder()
                case self.tf3:
                    self.tf4.becomeFirstResponder()
                case self.tf4:
                    self.tf5.becomeFirstResponder()
                case self.tf5:
                    self.tf6.becomeFirstResponder()
                case self.tf6:
                    self.tf6.resignFirstResponder()
                default:
                    print("error")
                }
            }
            return false
        }
        if string != ""{
            DispatchQueue.main.async {
                switch textField {
                case self.tf1:
                    self.tf2.becomeFirstResponder()
                case self.tf2:
                    self.tf3.becomeFirstResponder()
                case self.tf3:
                    self.tf4.becomeFirstResponder()
                case self.tf4:
                    self.tf5.becomeFirstResponder()
                case self.tf5:
                    self.tf6.becomeFirstResponder()
                case self.tf6:
                    self.tf6.resignFirstResponder()
                default:
                    print("error")
                }
            }
        }
        return true
    }
}


// MARK: - EXTERNAL FUNCTIONS
extension phoneVerificationVC{
    @objc func btnActNext(_ sender: UIButton){
        let vc = phoneVerifySuccessVC.instantiateFromAppStoryboard(appStoryboard: .Main)
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
