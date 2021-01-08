//
//  editProfileVC.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 23/12/20.
//

import UIKit
import GrowingTextView
import FlagPhoneNumber
import SkyFloatingLabelTextField

class editProfileVC: headerVC {
    
    // MARK: - UI COMPONENTS
    @IBOutlet weak var imgViewDP: UIImageView!
    @IBOutlet weak var btnDP: UIButton!
    @IBOutlet weak var tfFirstName: SkyFloatingLabelTextField!
    @IBOutlet weak var tfLastName: SkyFloatingLabelTextField!
    @IBOutlet weak var tfEmail: SkyFloatingLabelTextField!
    @IBOutlet weak var tfPhoneNumber: SkyFloatingLabelTextField!
    @IBOutlet weak var tfWork: SkyFloatingLabelTextField!
    
    @IBOutlet weak var lblAbout: UILabel!
    @IBOutlet weak var tvAbout: GrowingTextView!
    @IBOutlet weak var vwAbout: UIView!
    @IBOutlet weak var constTopUpper: NSLayoutConstraint!
    @IBOutlet weak var scrllView: UIScrollView!
    

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
    var keyboardHeight : CGFloat = 0

    
    // MARK: - OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        isBackEnabled = true
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
}


// MARK: - SET UP UI
extension editProfileVC{
    func setUpUI(){
        lblHeader.text = L10n.EditProfile.description
        btnRight.setTitle(L10n.SAVE.description, for: .normal)
        
        imgViewDP.layer.cornerRadius = imgViewDP.frame.height/2
        
        CommonFunctions.normalSkyTF(tfFirstName, img: nil,
                                    placeHolder: L10n.FirstName.description)
        CommonFunctions.normalSkyTF(tfLastName, img: nil,
                                    placeHolder: L10n.LastName.description)
        CommonFunctions.normalSkyTF(tfEmail, img: nil,
                                    placeHolder: L10n.Email.description)
        CommonFunctions.normalSkyTF(tfPhoneNumber, img: nil,
                                    placeHolder: "              \(L10n.PhoneNumber.description)")
        CommonFunctions.normalSkyTF(tfWork, img: nil,
                                    placeHolder: L10n.Business.description)

        
        let phoneVw = UIView(frame: CGRect(x: 0, y: 0, width: 52, height: 44))
        phoneVw.backgroundColor = UIColor.clear
//        let lineVw = UIView(frame: CGRect(x: 43, y: 20, width: 1, height: 18))
//        lineVw.backgroundColor = UIColor.textColorPlaceholder
        
        phoneVw.addSubview(btnPhoneNumber)
//        phoneVw.addSubview(lineVw)

        tfPhoneNumber.title = L10n.PhoneNumber.description
        tfPhoneNumber.leftView = phoneVw
        tfPhoneNumber.leftViewMode = .always

        let btnPhoneVerify = getVerifyBtn()
        btnPhoneVerify.1.addTarget(self, action: #selector(btnActPhoneNumberVerify(_:)), for: .touchUpInside)
        tfPhoneNumber.rightView = btnPhoneVerify.0
        tfPhoneNumber.rightViewMode = .always

        let imgEmailVerify = getVerifyImage()
        tfEmail.rightView = imgEmailVerify
        tfEmail.rightViewMode = .always

        tvAbout.font = UIFont.MontserratMedium(Size.Medium.sizeValue())
        tvAbout.textColor = UIColor.textColorMain
        tvAbout.tintColor = UIColor.textColorMain
        tvAbout.placeholderColor = UIColor.textColorPlaceholder
        tvAbout.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tvAbout.placeholder = ""//L10n.TellUsAboutYoursef.description
        
//        lblAbout.font = UIFont.MontserratMedium(Size.Small.sizeValue())
        lblAbout.font = UIFont.MontserratMedium(Size.Medium.sizeValue())
        lblAbout.text = L10n.AboutText.description
        lblAbout.textColor = UIColor.textColorPlaceholder

        vwAbout.backgroundColor = UIColor.textColorPlaceholder
        
        btnRight.addTarget(self, action: #selector(btnActSave(_:)), for: .touchUpInside)
        btnPhoneNumber.addTarget(self, action: #selector(btnActCountryCode(_:)), for: .touchUpInside)
        btnDP.addTarget(self, action: #selector(btnActDP(_:)), for: .touchUpInside)

    }
    
    func getVerifyBtn () -> (UIView, UIButton){
        let mView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 48))
        let btn = UIButton(frame: CGRect(x: 0, y: 20, width: 44, height: 24))
        btn.setTitle(L10n.Verify.description, for: .normal)
        btn.setTitleColor(UIColor.themeColor, for: .normal)
        btn.titleLabel?.font = UIFont.MontserratMedium(Size.Medium.sizeValue())
        mView.addSubview(btn)
        return (mView, btn)
    }
    
    func getVerifyImage() -> UIView{
        let mView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 48))
        let imgVw = UIImageView(frame: CGRect(x: 0, y: 20, width: 20, height: 24))
        imgVw.image = Asset.verified.image()
        imgVw.contentMode = .center
        mView.addSubview(imgVw)
        return mView
    }
}


// MARK: - UI TEXTFIELD DELEGATE
extension editProfileVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case tfFirstName:
            tfLastName.becomeFirstResponder()
        case tfLastName:
            tfEmail.becomeFirstResponder()
        case tfEmail:
            tfPhoneNumber.becomeFirstResponder()
        case tfPhoneNumber:
            tfWork.becomeFirstResponder()
        case tfWork:
            tvAbout.becomeFirstResponder()
        default:
            view.endEditing(true)
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        if tfPhoneNumber == textField{
            return newString.length <= 15
        }else if tfFirstName == textField || tfLastName == textField{
            return newString.length <= 20
        }else if tfWork == textField{
            return newString.length <= 40
        }else if tfEmail == textField{
            return newString.length <= 40
        }
        return true
    }
}


// MARK: - UI TEXTVIEW DELEGATE
extension editProfileVC: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentString: NSString = textView.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: text) as NSString
        if textView.text == "" && text != ""{
            lblAbout.textColor = UIColor.themeColor
            vwAbout.backgroundColor = UIColor.themeColor
            lblAbout.text = L10n.AboutText.description
            constTopUpper.constant = -20
            lblAbout.font = UIFont.MontserratMedium(Size.Small.sizeValue())
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
        if newString == ""{
//            if lblAbout.text != L10n.Message.description{
                lblAbout.textColor = UIColor.textColorPlaceholder
                vwAbout.backgroundColor = UIColor.textColorPlaceholder
                lblAbout.text = L10n.AboutText.description
                constTopUpper.constant = 0
                UIView.animate(withDuration: 0.2) {
                    self.view.layoutIfNeeded()
                }
                lblAbout.font = UIFont.MontserratMedium(Size.Medium.sizeValue())
//            }
        }
        scrllView.setContentOffset(CGPoint(x: 0, y: textView.frame.maxY - (scrllView.frame.height - keyboardHeight + self.view.safeAreaInsets.bottom - 12)), animated: true)
        return newString.length <= 520
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        lblAbout.textColor = UIColor.themeColor
        vwAbout.backgroundColor = UIColor.themeColor
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        lblAbout.textColor = UIColor.textColorPlaceholder
        vwAbout.backgroundColor = UIColor.textColorPlaceholder
    }
}


// MARK: - EXTERNAL FUNCTIONS
extension editProfileVC{
    @objc func keyboardWillShow(_ notification: NSNotification){
        if let userInfo = notification.userInfo{
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue)
            let rect = keyboardFrame.cgRectValue
            keyboardHeight = rect.height
        }
    }
    
    @objc func btnActSave(_ sender: UIButton){
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func btnActEmailVerify(_ sender: UIButton){
        self.view.endEditing(true)

    }

    @objc func btnActDP(_ sender: UIButton){
        self.view.endEditing(true)

    }

    @objc func btnActPhoneNumberVerify(_ sender: UIButton){
        self.view.endEditing(true)

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
}
