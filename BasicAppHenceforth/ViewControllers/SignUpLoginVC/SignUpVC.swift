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
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var lblOrContinue: UILabel!
    @IBOutlet weak var btnAppleLogin: UIButton!
    @IBOutlet weak var btnGoogleLogin: UIButton!
    @IBOutlet weak var btnFbLogin: UIButton!
    @IBOutlet weak var lblAttributtedLogin: UILabel!
    @IBOutlet weak var lblTermsPrivacy: ActiveLabel!
        
    fileprivate lazy var btnPhoneNumber : UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 14, width: 44, height: 30))
        btn.titleLabel?.font = UIFont.MontserratMedium(Size.Medium.sizeValue())
        btn.setTitleColor(UIColor.textColorMain, for: .normal)
        btn.setTitle("+971", for: .normal)
        return btn
    }()
    
    
    //MARK:- Variables
    var selectedValue = "+971"
    var countryCode = ""
    
    
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
        
        lblHeader.text = L10n.CreateNewAccount.description
        btnRight.setTitle(L10n.SKIP.description, for: .normal)
        
        CommonFunctions.normalSkyTF(tfFirstName, img: Asset.user.image(), placeHolder: L10n.FirstName.description)
        CommonFunctions.normalSkyTF(tfLastName, img: Asset.user.image(), placeHolder: L10n.LastName.description)
        CommonFunctions.normalSkyTF(tfEmail, img: Asset.email.image(), placeHolder: L10n.Email.description)
        let btneye1 = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        btneye1.tag = 0
        let btneye2 = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        btneye2.tag = 1
        btneye1.addTarget(self, action: #selector(btnActEye(_:)) , for: .touchUpInside)
        btneye2.addTarget(self, action: #selector(btnActEye(_:)) , for: .touchUpInside)
        CommonFunctions.normalSkyTFBtn(tfPassword, btn: btneye1, placeHolder: L10n.Password.description)
        CommonFunctions.normalSkyTFBtn(tfConfirmPassword, btn: btneye2, placeHolder: L10n.ConfirmPassword.description)

        CommonFunctions.setbuttonBoarder(4, [btnSignUp, btnFbLogin, btnAppleLogin, btnGoogleLogin])
        
        btnSignUp.titleLabel?.font = UIFont.MontserratSemiBold(Size.Medium.sizeValue())
        btnSignUp.setTitleColor(UIColor.appWhiteColor, for: .normal)
        
        //MARK:- Implement country code in textfield
        btnPhoneNumber.addTarget(self, action: #selector(btnActCountryCode(_:)), for: .touchUpInside)
        
        let phoneVw = UIView(frame: CGRect(x: 0, y: 0, width: 48, height: 44))
        phoneVw.backgroundColor = UIColor.clear
        let lineVw = UIView(frame: CGRect(x: 43, y: 20, width: 1, height: 18))
        lineVw.backgroundColor = UIColor.textColorPlaceholder
        
        phoneVw.addSubview(btnPhoneNumber)
        phoneVw.addSubview(lineVw)

        CommonFunctions.normalSkyTF(tfPhoneNumber, img: Asset.ic_phone_number.image(), placeHolder: "             \(L10n.PhoneNumber.description)")
        tfPhoneNumber.title = L10n.PhoneNumber.description
        tfPhoneNumber.leftView = phoneVw
        tfPhoneNumber.leftViewMode = .always
        
        // attributed label setting with gesture
        let first = [NSAttributedString.Key.foregroundColor: UIColor.textColorOne, NSAttributedString.Key.font: UIFont.MontserratMedium(Size.Medium.sizeValue())]
        let second = [NSAttributedString.Key.foregroundColor: Colors.greenThemeColor.color(), NSAttributedString.Key.font: UIFont.MontserratMedium(Size.Medium.sizeValue())] as [NSAttributedString.Key : Any]
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
            CommonFunctions.toster("Terms and Cond")
        }
        
        lblTermsPrivacy.handleCustomTap(for: customType2) { element in
            CommonFunctions.toster("Privacy Policy")
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
            return newString.length <= 15
        }else if tfFirstName == textField || tfLastName == textField{
            return newString.length <= 20
        }else if tfPassword == textField || tfConfirmPassword == textField{
            return newString.length <= 20
        }else if tfEmail == textField{
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
        let vc = phoneVerificationVC.instantiateFromAppStoryboard(appStoryboard: AppStoryboard.Main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnActAppleLogin(_ sender: Any) {
        self.view.endEditing(true)
        let vc = tabbarVC.instantiateFromAppStoryboard(appStoryboard: .Tabbar)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnActGoogleLogin(_ sender: Any) {
        self.view.endEditing(true)
        let vc = tabbarVC.instantiateFromAppStoryboard(appStoryboard: .Tabbar)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnActFacebookLogin(_ sender: Any) {
        self.view.endEditing(true)
        let vc = tabbarVC.instantiateFromAppStoryboard(appStoryboard: .Tabbar)
        self.navigationController?.pushViewController(vc, animated: true)
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
        counListing.setup(repository: pTf.countryRepository)
        counListing.didSelect = {[weak self] country in
            self?.btnPhoneNumber.setTitle(country.phoneCode, for: .normal)
            self?.selectedValue = country.phoneCode
            self?.countryCode = country.code.rawValue
        }
        self.present(counListing, animated: true, completion: nil)
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
