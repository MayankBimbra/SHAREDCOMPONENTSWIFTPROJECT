//
//  profileVC.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 22/12/20.
//

import UIKit

class profileVC: headerVC {

    // MARK: - UI COMPONENTS
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var imgViewProfileOuter: UIView!
    @IBOutlet weak var imgViewDP: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnShowProfile: UIButton!
    
    @IBOutlet weak var lblAccountSetting: UILabel!
    @IBOutlet weak var viewPersonalInfo: UIView!
    @IBOutlet weak var btnPersonalInfo: UIButton!
    @IBOutlet weak var viewNotification: UIView!
    @IBOutlet weak var btnNotification: UIButton!
    @IBOutlet weak var viewChangePass: UIView!
    @IBOutlet weak var btnChangePass: UIButton!
    @IBOutlet weak var viewLanguage: UIView!
    @IBOutlet weak var btnLanguage: UIButton!
    
    @IBOutlet weak var lblSupport: UILabel!
    @IBOutlet weak var viewContactUs: UIView!
    @IBOutlet weak var btnContactUs: UIButton!
    @IBOutlet weak var viewHelpCenter: UIView!
    @IBOutlet weak var btnHelpCenter: UIButton!
    @IBOutlet weak var viewAboutUs: UIView!
    @IBOutlet weak var btnAboutUs: UIButton!
    
    @IBOutlet weak var lblFeedback: UILabel!
    @IBOutlet weak var viewRateApp: UIView!
    @IBOutlet weak var btnRateApp: UIButton!
    @IBOutlet weak var viewShareApp: UIView!
    @IBOutlet weak var btnShareApp: UIButton!
    
    @IBOutlet weak var lblLegal: UILabel!
    @IBOutlet weak var viewPrivacyPolicy: UIView!
    @IBOutlet weak var btnPrivacyPolicy: UIButton!
    @IBOutlet weak var viewTermsCond: UIView!
    @IBOutlet weak var btnTermsCond: UIButton!
    @IBOutlet weak var viewLogOut: UIView!
    @IBOutlet weak var btnLogOut: UIButton!
    
    @IBOutlet weak var lblAppVersion: UILabel!
    
    
    // MARK: - VARIABLES
    var profileVM = ProfileVM.shared

    
    
    // MARK: - OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lblName.text = "\(userData.shared.firstName) \(userData.shared.lastName)"
        imgViewDP.yy_setImage(with: URL(string: CommonFunctions.getImage(userData.shared.profileImage, quality: .medium)), placeholder: nil)
    }
}


// MARK: - SET UP UI
extension profileVC{
    func setUpUI(){
        profileVM.controller = self
        lblHeader.text = L10n.SETTING.description
        
        imgViewProfileOuter.layer.cornerRadius = imgViewProfileOuter.frame.height/2
        imgViewProfileOuter.layer.borderWidth = 2
        imgViewProfileOuter.layer.borderColor = UIColor.themeColor.cgColor

        imgViewDP.layer.cornerRadius = imgViewDP.frame.height/2
        lblName.font = UIFont.MontserratSemiBold(Size.Header.sizeValue())
        lblName.textColor = UIColor.appBlackColor
        btnShowProfile.setTitleColor(UIColor.themeColor, for: .normal)
        btnShowProfile.titleLabel?.font = UIFont.MontserratMedium(Size.Medium.sizeValue())
        btnShowProfile.setTitle(L10n.ShowProfile.description, for: .normal)

        headingSetting(lblAccountSetting, txt: L10n.ACCOUNT_SETTINGS.description)
        headingSetting(lblSupport, txt: L10n.SUPPORT.description)
        headingSetting(lblFeedback, txt: L10n.FEEDBACK.description)
        headingSetting(lblLegal, txt: L10n.LEGAL.description)
        headingSetting(lblAppVersion, txt: L10n.AppVeriosn.description)
    
        btnSetting(btnPersonalInfo, txt: L10n.Personal_Information.description)
        btnSetting(btnNotification, txt: L10n.Notifications.description)
        btnSetting(btnChangePass, txt: L10n.Change_Password.description)
        btnSetting(btnLanguage, txt: L10n.Language.description)
        btnSetting(btnContactUs, txt: L10n.Contact_Us.description)
        btnSetting(btnHelpCenter, txt: L10n.Help_Center.description)
        btnSetting(btnAboutUs, txt: L10n.About_Us.description)
        btnSetting(btnRateApp, txt: L10n.Rate_App.description)
        btnSetting(btnShareApp, txt: L10n.Share_App.description)
        btnSetting(btnPrivacyPolicy, txt: L10n.Privacy_Policy.description)
        btnSetting(btnTermsCond, txt: L10n.Terms_and_Conditions.description)
        btnSetting(btnLogOut, txt: L10n.Log_Out.description)

        btnShowProfile.addTarget(self, action: #selector(btnActProfile(_:)), for: .touchUpInside)
        btnPersonalInfo.addTarget(self, action: #selector(btnActPersonalInfo(_:)), for: .touchUpInside)
        btnNotification.addTarget(self, action: #selector(btnActNotification(_:)), for: .touchUpInside)
        btnChangePass.addTarget(self, action: #selector(btnActChangePass(_:)), for: .touchUpInside)
        btnLanguage.addTarget(self, action: #selector(btnActLanguage(_:)), for: .touchUpInside)
        btnContactUs.addTarget(self, action: #selector(btnActContactUs(_:)), for: .touchUpInside)
        btnHelpCenter.addTarget(self, action: #selector(btnActHelpCenter(_:)), for: .touchUpInside)
        btnAboutUs.addTarget(self, action: #selector(btnActAboutUs(_:)), for: .touchUpInside)
        btnRateApp.addTarget(self, action: #selector(btnActRateApp(_:)), for: .touchUpInside)
        btnShareApp.addTarget(self, action: #selector(btnActShareApp(_:)), for: .touchUpInside)
        btnPrivacyPolicy.addTarget(self, action: #selector(btnActPrivacyPolicy(_:)), for: .touchUpInside)
        btnTermsCond.addTarget(self, action: #selector(btnActTermsCond(_:)), for: .touchUpInside)
        btnLogOut.addTarget(self, action: #selector(btnActLogOut(_:)), for: .touchUpInside)
        
        lblName.text = "\(userData.shared.firstName) \(userData.shared.lastName)"
        
        imgViewDP.yy_setImage(with: URL(string: CommonFunctions.getImage(userData.shared.profileImage, quality: .medium)), placeholder: nil)

    }
    
    func headingSetting(_ lbl: UILabel, txt: String){
        lbl.font = UIFont.MontserratMedium(Size.Small.sizeValue())
        lbl.textColor = UIColor.textColorTwo
        lbl.text = txt
    }
    
    func btnSetting(_ btn: UIButton, txt: String){
        btn.titleLabel?.font = UIFont.MontserratMedium(Size.Medium.sizeValue())
        btn.setTitleColor(UIColor.appBlackColor, for: .normal)
        btn.setTitle(txt, for: .normal)
    }
}


// MARK: - EXTERNAL FUNCTIONS
extension profileVC{
    @objc func btnActProfile(_ sender: UIButton){
        let vc = profileInnerVC.instantiateFromAppStoryboard(appStoryboard: .Profile)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func btnActPersonalInfo(_ sender: UIButton){
        let vc = profileInnerVC.instantiateFromAppStoryboard(appStoryboard: .Profile)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc func btnActNotification(_ sender: UIButton){
        let vc = notificationAskVC.instantiateFromAppStoryboard(appStoryboard: .Account)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc func btnActChangePass(_ sender: UIButton){
        let vc = changePasswordVC.instantiateFromAppStoryboard(appStoryboard: .Account)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc func btnActLanguage(_ sender: UIButton){
        
    }
    
    @objc func btnActContactUs(_ sender: UIButton){
        let vc = contactUsVC.instantiateFromAppStoryboard(appStoryboard: .Account)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc func btnActHelpCenter(_ sender: UIButton){
        
    }

    @objc func btnActAboutUs(_ sender: UIButton){
        let vc = webPageVC.instantiateFromAppStoryboard(appStoryboard: .Account)
        vc.screenType = .AboutUs
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc func btnActRateApp(_ sender: UIButton){
        if let url = URL(string: "https://apps.apple.com/in/app/rxhub/id1520523866?action=write-review") {
          UIApplication.shared.open(url)
        }
    }

    @objc func btnActShareApp(_ sender: UIButton){
        let items = ["Hey, checked this app on appstore", URL(string: "https://apps.apple.com/in/app/rxhub/id1520523866")!] as [Any]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        self.present(ac, animated: true)
    }

    @objc func btnActPrivacyPolicy(_ sender: UIButton){
        let vc = webPageVC.instantiateFromAppStoryboard(appStoryboard: .Account)
        vc.screenType = .PrivacyPolicy
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc func btnActTermsCond(_ sender: UIButton){
        let vc = webPageVC.instantiateFromAppStoryboard(appStoryboard: .Account)
        vc.screenType = .TermsAndCond
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc func btnActLogOut(_ sender: UIButton){
        let alert = UIAlertController(title: L10n.Log_Out.description, message: L10n.LogOutDesc.description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: L10n.Yes.description, style: .destructive, handler: { _ in
            self.profileVM.logoutAPI()
            userData.shared.deleteData()
            CommonFunctions.logout()
        }))
        alert.addAction(UIAlertAction(title: L10n.No.description, style: .cancel, handler: { _ in }))
        self.present(alert, animated: true, completion: nil)
    }
}
