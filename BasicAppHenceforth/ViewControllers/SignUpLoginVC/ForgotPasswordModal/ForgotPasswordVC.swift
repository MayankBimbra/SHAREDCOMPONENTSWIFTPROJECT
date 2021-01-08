//
//  ForgotPasswordVC.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 21/12/20.
//

import UIKit
import SkyFloatingLabelTextField

class ForgotPasswordVC: headerVC {

    // MARK: - UI COMPONENTS
    @IBOutlet weak var lblEnterRegisteredEmail: UILabel!
    @IBOutlet weak var tfEmail: SkyFloatingLabelTextField!
    @IBOutlet weak var btnSubmit: LoadingButton!
    
    
    // MARK: - VARIABLES
    var forgotPasswordVM = ForgotPasswordVM.shared

    
    // MARK: - OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        isBackEnabled = true
        super.viewDidLoad()
        setUpUI()
    }
}


// MARK: - SET UP UI
extension ForgotPasswordVC{
    func setUpUI(){
        forgotPasswordVM.controller = self

        lblHeader.text = L10n.ForgotPasswordTitle.description
        
        lblEnterRegisteredEmail.attributedText = CommonFunctions.sendAttText([L10n.ForgotPasswordDesc.description], fonts: [UIFont.MontserratMedium(Size.Large.sizeValue())], color: [UIColor.textColorOne], alingment: .left, spacing: 4)
        
        CommonFunctions.normalSkyTF(tfEmail, img: Asset.email.image(), placeHolder: L10n.Email.description)

        CommonFunctions.setbuttonBoarder(4, [btnSubmit])
        btnSubmit.setTitle(L10n.SUBMIT.description, for: .normal)
        btnSubmit.titleLabel?.font = UIFont.MontserratSemiBold(Size.Medium.sizeValue())
        btnSubmit.addTarget(self, action: #selector(btnActSubmit(_:)), for: .touchUpInside)

    }
}


// MARK: - DELEGATE FUNCTIONS
extension ForgotPasswordVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        if tfEmail == textField{
            CommonFunctions.normalSkyTF(tfEmail, img: Asset.email.image(), placeHolder: L10n.Email.description)
            return newString.length <= 40
        }
        return true

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


// MARK: - EXTERNAL FUNCTIONS
extension ForgotPasswordVC{
    @objc func btnActSubmit(_ sender: UIButton){
        forgotPasswordVM.checkVerificationEmail()
    }
}
