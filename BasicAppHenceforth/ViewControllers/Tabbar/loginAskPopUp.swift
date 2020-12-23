//
//  loginAskPopUp.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 22/12/20.
//

import UIKit

class loginAskPopUp: basePopUpVC {

    // MARK: - UI COMPONENTS
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var lblOr: UILabel!
    @IBOutlet weak var popCloseView: UIView!
    @IBOutlet weak var constMiddle: NSLayoutConstraint!
    
    
    // MARK: - VARIABLES

    
    // MARK: - OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        self.popVw = self.popUpView
        self.backVw = self.popCloseView
        self.middleConst = self.constMiddle
        super.viewDidLoad()
        setUpUI()
    }
}


// MARK: - SET UP UI
extension loginAskPopUp{
    func setUpUI(){
        popUpView.layer.cornerRadius = 4
        
        lblHeader.attributedText = CommonFunctions.sendAttText([L10n.SignPopUpHeader.description], fonts: [UIFont.MontserratSemiBold(Size.XLarge.sizeValue())], color: [UIColor.black], alingment: .left, spacing: 4)
        lblDescription.attributedText = CommonFunctions.sendAttText([L10n.SignPopUpDecs.description], fonts: [UIFont.MontserratMedium(Size.Medium.sizeValue())], color: [UIColor.textColorMain], alingment: .left, spacing: 4)
        lblOr.attributedText = CommonFunctions.sendAttText([L10n.SignPopUpOr.description], fonts: [UIFont.MontserratMedium(Size.Medium.sizeValue())], color: [UIColor.textColorTwo], alingment: .center, spacing: 4)

        btnSignUp.layer.cornerRadius = 4
        btnSignUp.layer.borderWidth = 1
        btnSignUp.layer.borderColor = UIColor.themeColor.cgColor
        btnSignUp.backgroundColor = UIColor.appWhiteColor
        btnSignUp.setTitleColor(UIColor.themeColor, for: .normal)
        btnSignUp.setTitle(L10n.SignPopUpSignUp.description, for: .normal)
        btnSignUp.titleLabel?.font = UIFont.MontserratSemiBold(Size.Medium.sizeValue())
        
        btnLogin.layer.cornerRadius = 4
        btnLogin.backgroundColor = UIColor.themeColor
        btnLogin.setTitleColor(UIColor.appWhiteColor, for: .normal)
        btnLogin.setTitle(L10n.SIGNIN.description, for: .normal)
        btnLogin.titleLabel?.font = UIFont.MontserratSemiBold(Size.Medium.sizeValue())

        
        btnLogin.addTarget(self, action: #selector(btnActSignIn(_:)), for: .touchUpInside)
        btnSignUp.addTarget(self, action: #selector(btnActSignUp(_:)), for: .touchUpInside)
        btnClose.addTarget(self, action: #selector(btnActClose(_:)), for: .touchUpInside)

    }
}


// MARK: - EXTERNAL FUNCTIONS
extension loginAskPopUp{
    @objc func btnActSignIn(_ sender: UIButton){
        stopAnimation()
    }
    
    @objc func btnActSignUp(_ sender: UIButton){
        stopAnimation()
    }

    @objc func btnActClose(_ sender: UIButton){
        stopAnimation()
    }
}
