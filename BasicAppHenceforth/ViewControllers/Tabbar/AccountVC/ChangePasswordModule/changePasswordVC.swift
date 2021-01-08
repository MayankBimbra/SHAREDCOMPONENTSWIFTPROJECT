//
//  changePasswordVC.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 23/12/20.
//

import UIKit
import SkyFloatingLabelTextField

class changePasswordVC: headerVC {

    // MARK: - UI COMPONENTS
    @IBOutlet weak var tfNewPassword: SkyFloatingLabelTextField!
    @IBOutlet weak var tfConfirmPassword: SkyFloatingLabelTextField!
    @IBOutlet weak var btnUpdatePassword: LoadingButton!
    
    
    
    // MARK: - VARIABLES
    var changePasswordVM = ChangePasswordVM.shared
    var btneye1 : UIButton = UIButton()
    var btneye2 : UIButton = UIButton()

    
    // MARK: - OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        isBackEnabled = true
        super.viewDidLoad()
        setUpUI()
    }
}


// MARK: - SET UP UI
extension changePasswordVC{
    func setUpUI(){
        changePasswordVM.controller = self
        lblHeader.text = L10n.Change_Password.description
        btneye1 = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        btneye1.tag = 0
        btneye2 = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        btneye2.tag = 1
        btneye1.addTarget(self, action: #selector(btnActEye(_:)) , for: .touchUpInside)
        btneye2.addTarget(self, action: #selector(btnActEye(_:)) , for: .touchUpInside)
        CommonFunctions.normalSkyTFBtn(tfNewPassword, btn: btneye1, placeHolder: L10n.OldPassword.description)
        CommonFunctions.normalSkyTFBtn(tfConfirmPassword, btn: btneye2, placeHolder: L10n.NewPassword.description)
        
        btnUpdatePassword.setTitle(L10n.UpdatePassword.description, for: .normal)
        btnUpdatePassword.titleLabel?.font = UIFont.MontserratSemiBold(Size.Medium.sizeValue())
        btnUpdatePassword.setTitleColor(UIColor.appWhiteColor, for: .normal)
        btnUpdatePassword.backgroundColor = UIColor.themeColor
        btnUpdatePassword.layer.cornerRadius = 4
        
        btnUpdatePassword.addTarget(self, action: #selector(btnActUpdatePassword(_:)), for: .touchUpInside)
        
    }
}


// MARK: - UI TEXT FIELD DELEGATE
extension changePasswordVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case tfNewPassword:
            tfConfirmPassword.becomeFirstResponder()
        case tfConfirmPassword:
            tfConfirmPassword.resignFirstResponder()
        default:
            view.endEditing(true)
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        if tfNewPassword == textField || tfConfirmPassword == textField{
            if tfNewPassword == textField{
                CommonFunctions.normalSkyTFBtn(tfNewPassword, btn: btneye1, placeHolder: L10n.OldPassword.description)
            }else if tfConfirmPassword == textField{
                CommonFunctions.normalSkyTFBtn(tfConfirmPassword, btn: btneye2, placeHolder: L10n.NewPassword.description)
            }
            return newString.length <= 20
        }
        return true
    }
}


// MARK: - EXTERNAL FUNCTIONS
extension changePasswordVC{
    @objc func btnActEye(_ sender: UIButton){
        let tf = sender.tag == 0 ? tfNewPassword : tfConfirmPassword
        tf!.isSecureTextEntry = !tf!.isSecureTextEntry
        let img1 = Asset.ic_hideeye_review.image().imageWithInsets(insets: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))?.withRenderingMode(.alwaysTemplate)
        let img2 = Asset.ic_eye_review.image().imageWithInsets(insets: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))?.withRenderingMode(.alwaysTemplate)
        sender.setImage( tf!.isSecureTextEntry ? img1 : img2, for: .normal)
    }
    
    @objc func btnActUpdatePassword(_ sender: UIButton){
        changePasswordVM.checkValidations()
//        self.navigationController?.popViewController(animated: true)
    }
}
