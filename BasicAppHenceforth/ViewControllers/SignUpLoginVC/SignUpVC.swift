//
//  SignUpVC.swift
//  BasicAppHenceforth
//
//  Created by Think Recycling Pvt Ltd on 24/11/20.
//

import UIKit
import FlagPhoneNumber

class SignUpVC: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfPhoneNumber: FPNTextField!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnAppleLogin: UIButton!
    @IBOutlet weak var btnGoogleLogin: UIButton!
    @IBOutlet weak var btnFbLogin: UIButton!
    @IBOutlet weak var lblAttributtedLogin: UILabel!
    
    //MARK:- Variables
    var selectedValue = "+1"
    var countryCode = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        // Do any additional setup after loading the view.
    }

    //MARK:- Button Actions
    @IBAction func btnActSkip(_ sender: Any) {
    }
    
    @IBAction func btnActSignUp(_ sender: Any) {
    }
    
    @IBAction func btnActAppleLogin(_ sender: Any) {
    }
    
    @IBAction func btnActGoogleLogin(_ sender: Any) {
    }
    
    @IBAction func btnActFacebookLogin(_ sender: Any) {
    }
    
}

//MARK:- SetUp View Did Load Data
extension SignUpVC{
    func setUpUI(){
        CommonFunctions.setbuttonBoarder(4, [btnSignUp, btnFbLogin, btnAppleLogin, btnGoogleLogin])
        let btneye = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        let btnImage = UIImage(named: "visibility_off")?.imageWithInsets(insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 16))
        btneye.setImage(btnImage, for: .normal)
        btneye.addTarget(self, action: #selector(btnActEye(_:)) , for: .touchUpInside)
        tfPassword.rightViewMode = .always
        tfPassword.rightView = btneye
        
        //MARK:- Implement country code in textfield
        tfPhoneNumber.delegate = self
        tfPhoneNumber.displayMode = .list
        self.tfPhoneNumber.setFlag(countryCode: .US)
        tfPhoneNumber.setPlaceHolderColor(UIColor.lightGray, placeholderText: " 00000 00000 ", placeholderFont: UIFont.systemFont(ofSize: 14))
        tfPhoneNumber.flagButton.isUserInteractionEnabled = true
        tfPhoneNumber.flagButton.addTarget(self, action: #selector(btnActCountryCode(_:)), for: .touchUpInside)
        
        let first = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
        let second = [NSAttributedString.Key.foregroundColor: Colors.greenThemeColor.color(), NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14)] as [NSAttributedString.Key : Any]
        let One = NSMutableAttributedString(string: "Already have a account ?", attributes: first)
        let Two = NSMutableAttributedString(string: " Login", attributes: second)
        let tap = UITapGestureRecognizer(target: self, action: #selector(myMethodToHandleTap(_:)))
        One.append(Two)
        lblAttributtedLogin.attributedText = One
        lblAttributtedLogin.isUserInteractionEnabled = true
        lblAttributtedLogin.addGestureRecognizer(tap)
        lblAttributtedLogin.textAlignment = .center
    }
}

//MARK:- UITextField Delegate
extension SignUpVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        if tfPhoneNumber == textField{
            return newString.length <= 15
        }else if tfName == textField{
            return newString.length <= 40
        }else if tfEmail == textField{
            return newString.length <= 40
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case tfName:
            tfEmail.becomeFirstResponder()
        case tfEmail:
            tfPassword.becomeFirstResponder()
        case tfPassword:
            tfPhoneNumber.becomeFirstResponder()
        case tfPhoneNumber:
            tfPhoneNumber.resignFirstResponder()
        default:
            view.endEditing(true)
        }
        return true
    }
}

//MARK:- Objective C methods
extension SignUpVC{
    @objc func btnActEye(_ sender: UIButton){
        tfPassword.isSecureTextEntry = !tfPassword.isSecureTextEntry
        let btnImage1 = Asset.ic_hideeye_review.image().imageWithInsets(insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 12))
        let btnImage2 = Asset.ic_eye_review.image().imageWithInsets(insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 12))
        sender.setImage( tfPassword.isSecureTextEntry ? btnImage1 : btnImage2, for: .normal)
    }
    
    @objc func btnActCountryCode(_ sender: UIButton){
        self.fpnDisplayCountryList()
    }
    
    @objc func myMethodToHandleTap(_ sender : UITapGestureRecognizer){
        let text = (lblAttributtedLogin.text)!
        let range = (text as NSString).range(of: " Login")
//        let range2 = (text as NSString).range(of: "conditions.")
        if sender.didTapAttributedTextlbl(textField: self.lblAttributtedLogin, inRange: range) {
//            let vc = TermsAndConditionVC.instantiateFromAppStoryboard(appStoryboard: .Tabbar)
//            vc.sType = .termsAndCondtion
//            self.navigationController?.pushViewController(vc, animated: true)
            CommonFunctions.toster("Login")
        }
    }
}

//MARK:- Delegate method of country code flag
extension SignUpVC: FPNTextFieldDelegate{
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
         print(name, dialCode, code) // Output "France", "+33", "FR"
        countryCode = dialCode
//        coredata.shared.countryCode = dialCode
//        coredata.shared.dataSave()
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
//         if isValid {
//                // Do something...
//                textField.getFormattedPhoneNumber(format: .E164)        // Output "+33600000001"
//                textField.getFormattedPhoneNumber(format: .International) // Output "+33 6 00 00 00 01"
//                textField.getFormattedPhoneNumber(format: .National)       // Output "06 00 00 00 01"
//                textField.getFormattedPhoneNumber(format: .RFC3966)        // Output "tel:+33-6-00-00-00-01"
//                textField.getRawPhoneNumber()                               // Output "600000001"
//             } else {
//                // Do something...
//             }
    }
    
    func fpnDisplayCountryList() {
        print("sad")
        
        let listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
        tfPhoneNumber.displayMode = .list // .picker by default
        
        listController.setup(repository: tfPhoneNumber.countryRepository)
        listController.title = "Countries"
        

        let navigationViewController = UINavigationController(rootViewController: listController)
                
        self.present(navigationViewController, animated: true, completion: nil)
        
        
        listController.didSelect = {[weak self] country in
            self?.tfPhoneNumber.setFlag(countryCode: country.code)
            self?.selectedValue = country.phoneCode
        }
    }
}

//MARK:- Tap Gesture
extension UITapGestureRecognizer {
  func didTapAttributedTextlbl(textField: UILabel, inRange targetRange: NSRange) -> Bool {
    let layoutManager = NSLayoutManager()
    let textContainer = NSTextContainer(size: CGSize.zero)
    let textStorage = NSTextStorage(attributedString: textField.attributedText!)
    layoutManager.addTextContainer(textContainer)
    textStorage.addLayoutManager(layoutManager)
    textContainer.lineFragmentPadding = 0.0
    let labelSize = textField.bounds.size
    textContainer.size = labelSize
    let locationOfTouchInLabel = self.location(in: textField)
    let textBoundingBox = layoutManager.usedRect(for: textContainer)
    let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
    let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
    let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
    return NSLocationInRange(indexOfCharacter, targetRange)
  }
   
}
