//
//  contactUsVC.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 28/12/20.
//

import UIKit
import FlagPhoneNumber
import GrowingTextView
import SkyFloatingLabelTextField

class contactUsVC: headerVC {

    // MARK: - UI COMPONENT
    @IBOutlet weak var tfName: SkyFloatingLabelTextField!
    @IBOutlet weak var tfEmail: SkyFloatingLabelTextField!
    @IBOutlet weak var tfPhoneNumber: SkyFloatingLabelTextField!
    
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var tvMsg: GrowingTextView!
    @IBOutlet weak var vwMsg: UIView!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var constTopUpper: NSLayoutConstraint!
    
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
    
    
    // MARK:- VARIABLES
    var selectedValue = "+971"
    var countryCode = ""
    
    
    // MARK: - OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        isBackEnabled = true
        super.viewDidLoad()
        setUpUI()
    }
}


// MARK: - SET UP UI
extension contactUsVC{
    func setUpUI(){
        lblHeader.text = L10n.Contact_Us.description

        CommonFunctions.normalSkyTF(tfName, img: Asset.user.image(), placeHolder: L10n.Name.description)
        CommonFunctions.normalSkyTF(tfEmail, img: Asset.email.image(), placeHolder: L10n.Email.description)

        //MARK:- Implement country code in textfield
        btnPhoneNumber.addTarget(self, action: #selector(btnActCountryCode(_:)), for: .touchUpInside)
        
        let phoneVw = UIView(frame: CGRect(x: 0, y: 0, width: 52, height: 44))
        phoneVw.backgroundColor = UIColor.clear
//        let imgVw = UIImageView(frame: CGRect(x: 44, y: 0, width: 8, height: 44))
//        lineVw.backgroundColor = UIColor.textColorPlaceholder
        
        phoneVw.addSubview(btnPhoneNumber)
//        phoneVw.addSubview(lineVw)

        CommonFunctions.normalSkyTF(tfPhoneNumber, img: Asset.ic_phone_number.image(), placeHolder: "             \(L10n.PhoneNumber.description)")
        tfPhoneNumber.title = L10n.PhoneNumber.description
        tfPhoneNumber.leftView = phoneVw
        tfPhoneNumber.leftViewMode = .always
        
        CommonFunctions.setbuttonBoarder(4, [btnSubmit])
        
        tvMsg.font = UIFont.MontserratMedium(Size.Medium.sizeValue())
        tvMsg.textColor = UIColor.textColorMain
        tvMsg.tintColor = UIColor.textColorMain
        tvMsg.placeholderColor = UIColor.textColorPlaceholder
        tvMsg.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tvMsg.placeholder = ""//L10n.TypeMessage.description
        
        lblMsg.font = UIFont.MontserratMedium(Size.Medium.sizeValue())
//        lblMsg.font = UIFont.MontserratMedium(Size.Small.sizeValue())
        lblMsg.text = L10n.Message.description
        lblMsg.textColor = UIColor.textColorPlaceholder

        vwMsg.backgroundColor = UIColor.textColorPlaceholder

        
        btnSubmit.setTitle(L10n.SUBMIT.description, for: .normal)
        btnSubmit.titleLabel?.font = UIFont.MontserratSemiBold(Size.Medium.sizeValue())
        btnSubmit.setTitleColor(UIColor.appWhiteColor, for: .normal)
        btnSubmit.addTarget(self, action: #selector(btnActSubmit(_:)), for: .touchUpInside)
        
    }
}


// MARK: - UI TEXTFIELD DELEGATE
extension contactUsVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        if tfPhoneNumber == textField{
            return newString.length <= 15
        }else if tfName == textField{
            return newString.length <= 20
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
            tfPhoneNumber.becomeFirstResponder()
        case tfPhoneNumber:
            tfPhoneNumber.resignFirstResponder()
        default:
            view.endEditing(true)
        }
        return true
    }
    
}


// MARK: - UI TEXTVIEW DELEGATE
extension contactUsVC: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentString: NSString = textView.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: text) as NSString
        if textView.text == "" && text != ""{
            lblMsg.textColor = UIColor.themeColor
            vwMsg.backgroundColor = UIColor.themeColor
            lblMsg.text = L10n.Message.description.uppercased()
            constTopUpper.constant = -20
            lblMsg.font = UIFont.MontserratMedium(Size.Small.sizeValue())
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
        if newString == ""{
            if lblMsg.text != L10n.Message.description{
                lblMsg.textColor = UIColor.textColorPlaceholder
                vwMsg.backgroundColor = UIColor.textColorPlaceholder
                lblMsg.text = L10n.Message.description
                constTopUpper.constant = 0
                UIView.animate(withDuration: 0.2) {
                    self.view.layoutIfNeeded()
                }
                lblMsg.font = UIFont.MontserratMedium(Size.Medium.sizeValue())
            }
        }
        return newString.length <= 520
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        lblMsg.textColor = UIColor.themeColor
        vwMsg.backgroundColor = UIColor.themeColor
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        lblMsg.textColor = UIColor.textColorPlaceholder
        vwMsg.backgroundColor = UIColor.textColorPlaceholder
    }
}


// MARK: - EXTERNAL FUNCTIONS
extension contactUsVC{
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
    
    @objc func btnActSubmit(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
