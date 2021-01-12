//
//  SignUpVC.swift
//  BasicAppHenceforth
//
//  Created by Think Recycling Pvt Ltd on 24/11/20.
//

import UIKit
import ActiveLabel
import FlagPhoneNumber
import SkyFloatingLabelTextField

class SignUpVC: headerVC {

    //MARK:- UI COMPONENTS
    @IBOutlet weak var tfFirstName: SkyFloatingLabelTextField!
    @IBOutlet weak var tfLastName: SkyFloatingLabelTextField!
    @IBOutlet weak var tfEmail: SkyFloatingLabelTextField!
    @IBOutlet weak var tfPassword: SkyFloatingLabelTextField!
    @IBOutlet weak var tfConfirmPassword: SkyFloatingLabelTextField!
    @IBOutlet weak var tfPhoneNumber: SkyFloatingLabelTextField!
    @IBOutlet weak var btnSignUp: LoadingButton!
    @IBOutlet weak var lblOrContinue: UILabel!
    @IBOutlet weak var btnAppleLogin: LoadingButton!
    @IBOutlet weak var btnGoogleLogin: LoadingButton!
    @IBOutlet weak var btnFbLogin: LoadingButton!
    @IBOutlet weak var lblAttributtedLogin: UILabel!
    @IBOutlet weak var lblTermsPrivacy: ActiveLabel!
        
    var btnEye1 : UIButton!
    var btnEye2 : UIButton!

    fileprivate lazy var btnPhoneNumber : UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 14, width: 52, height: 30))
        btn.titleLabel?.font = UIFont.MontserratMedium(Size.Medium.sizeValue())
        btn.setTitleColor(UIColor.textColorMain, for: .normal)
        btn.setTitle("+971", for: .normal)
        let img = Asset.ic_downArrow.image().withRenderingMode(.alwaysTemplate)
        btn.setImage(img, for: .normal)
        btn.tintColor = UIColor.textColorMain
        btn.semanticContentAttribute = .forceRightToLeft
        return btn
    }()
    
    
    //MARK:- Variables
    var selectedValue = "+971"
    var countryCode = ""
    var signUpVM = SignUpVM.shared
    var socialVM = SocialVM.shared

    
    // MARK: - OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        // Do any additional setup after loading the view.
    }
}

//MARK:- SetUp View Did Load Data
extension SignUpVC{
    func setUpUI(){
        signUpVM.controller = self
        socialVM.controller = self
        lblHeader.text = L10n.CreateNewAccount.description
        btnRight.setTitle(L10n.SKIP.description, for: .normal)
        
        CommonFunctions.normalSkyTF(tfFirstName, img: Asset.user.image(), placeHolder: L10n.FirstName.description)
        CommonFunctions.normalSkyTF(tfLastName, img: Asset.user.image(), placeHolder: L10n.LastName.description)
        CommonFunctions.normalSkyTF(tfEmail, img: Asset.email.image(), placeHolder: L10n.Email.description)
        btnEye1 = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        btnEye1.tag = 0
        btnEye2 = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        btnEye2.tag = 1
        btnEye1.addTarget(self, action: #selector(btnActEye(_:)) , for: .touchUpInside)
        btnEye2.addTarget(self, action: #selector(btnActEye(_:)) , for: .touchUpInside)
        CommonFunctions.normalSkyTFBtn(tfPassword, btn: btnEye1, placeHolder: L10n.Password.description)
        CommonFunctions.normalSkyTFBtn(tfConfirmPassword, btn: btnEye2, placeHolder: L10n.ConfirmPassword.description)

        CommonFunctions.setbuttonBoarder(4, [btnSignUp, btnFbLogin, btnAppleLogin, btnGoogleLogin])
        
        btnSignUp.titleLabel?.font = UIFont.MontserratSemiBold(Size.Medium.sizeValue())
        btnSignUp.setTitleColor(UIColor.appWhiteColor, for: .normal)
        
        //MARK:- Implement country code in textfield
        btnPhoneNumber.addTarget(self, action: #selector(btnActCountryCode(_:)), for: .touchUpInside)
        
        let phoneVw = UIView(frame: CGRect(x: 0, y: 0, width: 52, height: 44))
        phoneVw.backgroundColor = UIColor.clear
//        let lineVw = UIView(frame: CGRect(x: 43, y: 20, width: 1, height: 18))
//        lineVw.backgroundColor = UIColor.textColorPlaceholder
        
        phoneVw.addSubview(btnPhoneNumber)
//        phoneVw.addSubview(lineVw)

        CommonFunctions.normalSkyTF(tfPhoneNumber, img: Asset.ic_phone_number.image(),
                                    placeHolder: "              \(L10n.PhoneNumber.description)")
        tfPhoneNumber.title = L10n.PhoneNumber.description
        tfPhoneNumber.leftView = phoneVw
        tfPhoneNumber.leftViewMode = .always
        
        // attributed label setting with gesture
        let first = [NSAttributedString.Key.foregroundColor: UIColor.textColorOne, NSAttributedString.Key.font: UIFont.MontserratMedium(Size.Medium.sizeValue())]
        let second = [NSAttributedString.Key.foregroundColor: UIColor.themeColor, NSAttributedString.Key.font: UIFont.MontserratMedium(Size.Medium.sizeValue())] as [NSAttributedString.Key : Any]
        let One = NSMutableAttributedString(string: L10n.AlreadyAccount.description, attributes: first)
        let Two = NSMutableAttributedString(string: L10n.AlreadyAccountLogin.description, attributes: second)
        let tap = UITapGestureRecognizer(target: self, action: #selector(myMethodToHandleTap(_:)))
        One.append(Two)
        lblAttributtedLogin.attributedText = One
        lblAttributtedLogin.isUserInteractionEnabled = true
        lblAttributtedLogin.addGestureRecognizer(tap)
        lblAttributtedLogin.textAlignment = .center
        
        btnRight.addTarget(self, action: #selector(btnActSkip(_:)), for: .touchUpInside)
        
        let customType = ActiveType.custom(pattern: "\\s\(L10n.TermsCond2.description)\\b") //Regex that looks for "with"
        let customType2 = ActiveType.custom(pattern: "\\s\(L10n.TermsCond4.description)\\b") //Regex that looks for "with"
        lblTermsPrivacy.enabledTypes = [customType, customType2]
        lblTermsPrivacy.text = L10n.TermsCond1.description + L10n.TermsCond2.description + L10n.TermsCond3.description + L10n.TermsCond4.description + " ."
        lblTermsPrivacy.textColor = UIColor.textColorOne
        lblTermsPrivacy.customColor[customType] = UIColor.themeColor
        lblTermsPrivacy.customSelectedColor[customType] = UIColor.themeColor
        lblTermsPrivacy.customColor[customType2] = UIColor.themeColor
        lblTermsPrivacy.customSelectedColor[customType2] = UIColor.themeColor
        lblTermsPrivacy.font = UIFont.MontserratMedium(Size.Medium.sizeValue())
            
        lblTermsPrivacy.handleCustomTap(for: customType) { element in
            let vc = webPageVC.instantiateFromAppStoryboard(appStoryboard: .Account)
            vc.screenType = .TermsAndCond
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        lblTermsPrivacy.handleCustomTap(for: customType2) { element in
            let vc = webPageVC.instantiateFromAppStoryboard(appStoryboard: .Account)
            vc.screenType = .PrivacyPolicy
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        if #available(iOS 13.0, *) {
            btnAppleLogin.isHidden = false
        } else {
            btnAppleLogin.isHidden = true
        }
    }
    
    func phoneNumberIsError(_ error: Bool){
        if error{
            btnPhoneNumber.tintColor = UIColor.errorColor
            btnPhoneNumber.setTitleColor(UIColor.errorColor, for: .normal)
        }else{
            btnPhoneNumber.tintColor = UIColor.textColorMain
            btnPhoneNumber.setTitleColor(UIColor.textColorMain, for: .normal)
        }
    }
}


// MARK:- UITextField Delegate
extension SignUpVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        if tfPhoneNumber == textField{
            CommonFunctions.normalSkyTF(tfPhoneNumber,
                                        img: Asset.ic_phone_number.image(),
                                        placeHolder: "              \(L10n.PhoneNumber.description)")
            self.phoneNumberIsError(false)
            return newString.length <= 15
        }else if tfFirstName == textField || tfLastName == textField{
            if tfFirstName == textField{
                CommonFunctions.normalSkyTF(tfFirstName,
                                            img: Asset.user.image(),
                                            placeHolder: L10n.FirstName.description)
            }else if tfLastName == textField{
                CommonFunctions.normalSkyTF(tfLastName,
                                            img: Asset.user.image(),
                                            placeHolder: L10n.LastName.description)
            }
            return newString.length <= 20
        }else if tfPassword == textField || tfConfirmPassword == textField{
            if tfPassword == textField{
                CommonFunctions.normalSkyTFBtn(tfPassword,
                                               btn: btnEye1,
                                               placeHolder: L10n.Password.description)
            }else if tfConfirmPassword == textField{
                CommonFunctions.normalSkyTFBtn(tfConfirmPassword,
                                               btn: btnEye2,
                                               placeHolder: L10n.ConfirmPassword.description)
            }
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
        case tfFirstName:
            tfLastName.becomeFirstResponder()
        case tfLastName:
            tfEmail.becomeFirstResponder()
        case tfEmail:
            tfPassword.becomeFirstResponder()
        case tfPassword:
            tfConfirmPassword.becomeFirstResponder()
        case tfConfirmPassword:
            tfPhoneNumber.becomeFirstResponder()
        case tfPhoneNumber:
            tfPhoneNumber.resignFirstResponder()
        default:
            view.endEditing(true)
        }
        return true
    }
}


// MARK:- Extennal Functions
extension SignUpVC{
    @objc func btnActSkip(_ sender: Any) {
        self.view.endEditing(true)
        let vc = tabbarVC.instantiateFromAppStoryboard(appStoryboard: .Tabbar)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnActSignUp(_ sender: Any) {
        self.view.endEditing(true)
        signUpVM.signUpChk()
    }
    
    @available(iOS 13.0, *)
    @IBAction func btnActAppleLogin(_ sender: Any) {
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
    
    @IBAction func btnActGoogleLogin(_ sender: Any) {
        self.view.endEditing(true)
        btnGoogleLogin.showLoading()
        self.view.isUserInteractionEnabled = false
        googleLoginClass.shared.googleLogin(self) { (result) in
            print(result)
            self.socialVM.socialLoginAPI(fbId: nil, googleID: result.id ?? "", appleID: nil, firstName: result.firstName ?? "", lastName: result.lastName ?? "", email: result.email ?? "") {
                self.btnGoogleLogin.hideLoading()
                self.view.isUserInteractionEnabled = true
            }
        } failure: {
            self.btnGoogleLogin.hideLoading()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    @IBAction func btnActFacebookLogin(_ sender: Any) {
        self.view.endEditing(true)
        btnFbLogin.showLoading()
        self.view.isUserInteractionEnabled = false
        fbLoginClass.facebookLogin(view: self) { (result) in
            print(result)
            self.socialVM.socialLoginAPI(fbId: result.id ?? "", googleID: nil, appleID: nil, firstName: result.firstName ?? "", lastName: result.lastName ?? "", email: result.email ?? "") {
                self.btnFbLogin.hideLoading()
                self.view.isUserInteractionEnabled = true
            }
        } failure: { (error) in
            self.btnFbLogin.hideLoading()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    @objc func btnActEye(_ sender: UIButton){
        let tf = sender.tag == 0 ? tfPassword : tfConfirmPassword
        tf!.isSecureTextEntry = !tf!.isSecureTextEntry
        let img1 = Asset.ic_hideeye_review.image().imageWithInsets(insets: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))?.withRenderingMode(.alwaysTemplate)
        let img2 = Asset.ic_eye_review.image().imageWithInsets(insets: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))?.withRenderingMode(.alwaysTemplate)
        sender.setImage( tf!.isSecureTextEntry ? img1 : img2, for: .normal)
    }
    
    @objc func btnActCountryCode(_ sender: UIButton){
        self.view.endEditing(true)
        let pTf = FPNTextField(frame: CGRect(x: 0, y: 0, width: view.bounds.width - 16, height: 50))
        pTf.displayMode = .list
        let counListing : FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
        counListing.showCountryPhoneCode = true
//        counListing.searchController =
        counListing.setup(repository: pTf.countryRepository)
        counListing.didSelect = {[weak self] country in
            self?.btnPhoneNumber.setTitle(country.phoneCode, for: .normal)
            self?.selectedValue = country.phoneCode
            self?.countryCode = country.code.rawValue
        }
        let navController = UINavigationController(rootViewController: counListing)
        self.present(navController, animated: true, completion: nil)
    }
    
    @objc func myMethodToHandleTap(_ sender : UITapGestureRecognizer){
        self.view.endEditing(true)
        let text = (lblAttributtedLogin.text)!
        let range = (text as NSString).range(of: L10n.AlreadyAccountLogin.description)
        if sender.didTapAttributedTextlbl(textField: self.lblAttributtedLogin, inRange: range) {
            
            let vcs = self.navigationController?.viewControllers
            var present = false
            for vc in vcs ?? []{
                if vc.isKind(of: LoginVC.self){
                    self.navigationController?.popToViewController(vc, animated: true)
                    present = true
                }
            }
            if !present{
                let vc = LoginVC.instantiateFromAppStoryboard(appStoryboard: .Main)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
