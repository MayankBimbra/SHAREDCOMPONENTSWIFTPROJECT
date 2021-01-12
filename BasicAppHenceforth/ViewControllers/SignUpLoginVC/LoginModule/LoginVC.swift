//
//  LoginVC.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 21/12/20.
//

import UIKit
import ActiveLabel
import SkyFloatingLabelTextField

class LoginVC: UIViewController {

    // MARK: - UI COMPONENTS
    @IBOutlet weak var tfEmail: SkyFloatingLabelTextField!
    @IBOutlet weak var tfPassword: SkyFloatingLabelTextField!
    @IBOutlet weak var btnLogin: LoadingButton!
    @IBOutlet weak var lblOrContinue: UILabel!
    @IBOutlet weak var btnAppleLogin: LoadingButton!
    @IBOutlet weak var btnGoogleLogin: LoadingButton!
    @IBOutlet weak var btnFbLogin: LoadingButton!
    @IBOutlet weak var lblAttributtedLogin: ActiveLabel!
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var lblWelcome: UILabel!
    @IBOutlet weak var btnForgotPassword: UIButton!
    
    
    // MARK: - Variables
    var loginVM = LoginVM.shared
    var socialVM = SocialVM.shared
    var btneye : UIButton!
    
    
    // MARK: - OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
}


// MARK: - SET UP UI
extension LoginVC{
    func setUpUI(){
        loginVM.controller = self
        socialVM.controller = self
        btnSkip.setTitle(L10n.SKIP.description, for: .normal)
        btnSkip.titleLabel?.font = UIFont.MontserratSemiBold(Size.Medium.sizeValue())

        lblWelcome.attributedText = CommonFunctions.sendAttText([L10n.WelcomeBack.description, "\n\(L10n.PleaseLogInToYourAccount.description)"], fonts: [UIFont.MontserratSemiBold(Size.Header.sizeValue()), UIFont.MontserratMedium(Size.Medium.sizeValue())], color: [UIColor.appBlackColor, UIColor.textColorOne], alingment: .left, spacing: 12)

        CommonFunctions.normalSkyTF(tfEmail, img: Asset.email.image(), placeHolder: L10n.Email.description)
        btneye = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        btneye.addTarget(self, action: #selector(btnActEye(_:)) , for: .touchUpInside)
        CommonFunctions.normalSkyTFBtn(tfPassword, btn: btneye, placeHolder: L10n.Password.description)

        CommonFunctions.setbuttonBoarder(4, [btnLogin, btnFbLogin, btnAppleLogin, btnGoogleLogin])
        
        btnForgotPassword.setTitle(L10n.ForgetPassword.description, for: .normal)
        btnForgotPassword.titleLabel?.font = UIFont.MontserratMedium(Size.Small.sizeValue())

        btnLogin.setTitle(L10n.SIGNIN.description, for: .normal)
        btnLogin.titleLabel?.font = UIFont.MontserratSemiBold(Size.Medium.sizeValue())
        btnLogin.setTitleColor(UIColor.appWhiteColor, for: .normal)
        
        let customType = ActiveType.custom(pattern: "\\\(L10n.SignUp.description)\\b") //Regex that looks for "with"
        lblAttributtedLogin.enabledTypes = [customType]
        lblAttributtedLogin.text = L10n.DontHaveAcc.description + L10n.SignUp.description
        lblAttributtedLogin.textColor = UIColor.textColorOne
        lblAttributtedLogin.customColor[customType] = UIColor.themeColor
        lblAttributtedLogin.customSelectedColor[customType] = UIColor.themeColor
        lblAttributtedLogin.font = UIFont.MontserratMedium(Size.Medium.sizeValue())
            
        lblAttributtedLogin.handleCustomTap(for: customType) { element in
            let vcs = self.navigationController?.viewControllers
            var present = false
            for vc in vcs ?? []{
                if vc.isKind(of: SignUpVC.self){
                    self.navigationController?.popToViewController(vc, animated: true)
                    present = true
                }
            }
            if !present{
                let vc = SignUpVC.instantiateFromAppStoryboard(appStoryboard: .Main)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
                
        btnSkip.addTarget(self, action: #selector(btnActSkip(_:)), for: .touchUpInside)
        btnLogin.addTarget(self, action: #selector(btnActLogin(_:)), for: .touchUpInside)
        if #available(iOS 13.0, *) {
            btnAppleLogin.isHidden = false
            btnAppleLogin.addTarget(self, action: #selector(btnActAppleLogin(_:)), for: .touchUpInside)
        } else {
            btnAppleLogin.isHidden = true
            // Fallback on earlier versions
        }
        btnGoogleLogin.addTarget(self, action: #selector(btnActGoogleLogin(_:)), for: .touchUpInside)
        btnFbLogin.addTarget(self, action: #selector(btnActFBLogin(_:)), for: .touchUpInside)
        btnForgotPassword.addTarget(self, action: #selector(btnActForgotPassword(_:)), for: .touchUpInside)
    }
}


// MARK:- UITextField Delegate
extension LoginVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        if tfPassword == textField{
            CommonFunctions.normalSkyTFBtn(tfPassword,
                                           btn: btneye,
                                           placeHolder: L10n.Password.description)
            return newString.length <= 20
        }else if tfEmail == textField{
            CommonFunctions.normalSkyTF(tfEmail,
                                        img: Asset.email.image(),
                                        placeHolder: L10n.Email.description)
            return newString.length <= 40
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case tfEmail:
            tfPassword.becomeFirstResponder()
        case tfPassword:
            tfPassword.resignFirstResponder()
        default:
            view.endEditing(true)
        }
        return true
    }
}


// MARK:- Extennal Functions
extension LoginVC{
    @objc func btnActSkip(_ sender: Any) {
        let vc = tabbarVC.instantiateFromAppStoryboard(appStoryboard: .Tabbar)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func btnActLogin(_ sender: Any) {
        self.view.endEditing(true)
        self.loginVM.checkLoginValidations()
    }
    
    
    @available(iOS 13.0, *)
    @objc func btnActAppleLogin(_ sender: Any) {
        self.view.endEditing(true)
        btnAppleLogin.showLoading()
        self.view.isUserInteractionEnabled = false
        appleLoginClass.shared.appleLogin(self) { (result) in
            self.socialVM.socialLoginAPI(fbId: nil, googleID: nil, appleID: result.id ?? "", firstName: result.firstName ?? "", lastName: result.lastName ?? "", email: result.email ?? "") {
                self.btnAppleLogin.hideLoading()
                self.view.isUserInteractionEnabled = true
            }
        } failure: {
            self.btnAppleLogin.hideLoading()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    @objc func btnActGoogleLogin(_ sender: Any) {
        self.view.endEditing(true)
        btnGoogleLogin.showLoading()
        self.view.isUserInteractionEnabled = false
        googleLoginClass.shared.googleLogin(self) { (result) in
            self.socialVM.socialLoginAPI(fbId: nil, googleID: result.id ?? "", appleID: nil, firstName: result.firstName ?? "", lastName: result.lastName ?? "", email: result.email ?? "") {
                self.btnGoogleLogin.hideLoading()
                self.view.isUserInteractionEnabled = true
            }
        } failure: {
            self.btnGoogleLogin.hideLoading()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    @objc func btnActFBLogin(_ sender: Any) {
        self.view.endEditing(true)
        btnFbLogin.showLoading()
        self.view.isUserInteractionEnabled = false
        fbLoginClass.facebookLogin(view: self) { (result) in
            self.socialVM.socialLoginAPI(fbId: result.id ?? "", googleID: nil, appleID: nil, firstName: result.firstName ?? "", lastName: result.lastName ?? "", email: result.email ?? "") {
                self.btnFbLogin.hideLoading()
                self.view.isUserInteractionEnabled = true
            }            
        } failure: { (error) in
            self.btnFbLogin.hideLoading()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    @objc func btnActForgotPassword(_ sender: Any) {
        let vc = ForgotPasswordVC.instantiateFromAppStoryboard(appStoryboard: .Main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func btnActEye(_ sender: UIButton){
        tfPassword!.isSecureTextEntry = !tfPassword!.isSecureTextEntry
        let img1 = Asset.ic_hideeye_review.image().imageWithInsets(insets: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))?.withRenderingMode(.alwaysTemplate)
        let img2 = Asset.ic_eye_review.image().imageWithInsets(insets: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))?.withRenderingMode(.alwaysTemplate)
        sender.setImage( tfPassword!.isSecureTextEntry ? img1 : img2, for: .normal)
    }
}
