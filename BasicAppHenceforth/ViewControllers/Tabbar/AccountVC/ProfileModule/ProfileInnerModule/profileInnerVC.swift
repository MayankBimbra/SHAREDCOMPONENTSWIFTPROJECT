//
//  profileInnerVC.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 23/12/20.
//

import UIKit

class profileInnerVC: headerVC {

    // MARK: - UI COMPONENTS
    @IBOutlet weak var profileViewOuter: UIView!
    @IBOutlet weak var imgViewDP: UIImageView!
    @IBOutlet weak var lblNameJoining: UILabel!
    
    @IBOutlet weak var lblAbout: UILabel!
    @IBOutlet weak var lblAboutDesc: UILabel!
    
    @IBOutlet weak var lblEmailText: UILabel!
    @IBOutlet weak var lblEmailVerified: UILabel!
    @IBOutlet weak var imgViewEmailVerified: UIImageView!
    
    @IBOutlet weak var lblPhoneNumText: UILabel!
    @IBOutlet weak var lblPhoneNumVerified: UILabel!
    @IBOutlet weak var imgViewPhoneVerified: UIImageView!
    
    @IBOutlet weak var lblBusinessText: UILabel!
    @IBOutlet weak var lblBusinessVerified: UILabel!
    
    
    
    
    
    // MARK: - VARIABLES
    var profileInnerVM = ProfileInnerVM.shared

    
    
    // MARK: - OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        isBackEnabled = true
        super.viewDidLoad()
        setUpUI()
        profileInnerVM.controller = self
        profileInnerVM.getProfileAPI()
        profileInnerVM.setUIData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        profileInnerVM.setUIData()
    }
}


// MARK: - SET UP UI
extension profileInnerVC{
    func setUpUI(){
        lblHeader.text = L10n.PROFILE.description
        btnRight.setImage(Asset.ic_edit_white.image(), for: .normal)

        profileViewOuter.layer.cornerRadius = profileViewOuter.frame.height/2
        profileViewOuter.layer.borderWidth = 2
        profileViewOuter.layer.borderColor = UIColor.themeColor.cgColor

        imgViewDP.layer.cornerRadius = imgViewDP.frame.height/2
        
        lblAbout.attributedText = CommonFunctions.sendAttText([L10n.AboutText.description], fonts: [UIFont.MontserratMedium(Size.Header.sizeValue())], color: [UIColor.appBlackColor], alingment: .left, spacing: 4)
        
        lblEmailText.attributedText = CommonFunctions.sendAttText([L10n.Email.description], fonts: [UIFont.MontserratMedium(Size.Small.sizeValue())], color: [UIColor.textColorTwo], alingment: .left, spacing: 4)
        lblPhoneNumText.attributedText = CommonFunctions.sendAttText([L10n.PhoneNumber.description], fonts: [UIFont.MontserratMedium(Size.Small.sizeValue())], color: [UIColor.textColorTwo], alingment: .left, spacing: 4)
        lblBusinessText.attributedText = CommonFunctions.sendAttText([L10n.Business.description], fonts: [UIFont.MontserratMedium(Size.Small.sizeValue())], color: [UIColor.textColorTwo], alingment: .left, spacing: 4)
        
        btnRight.addTarget(self, action: #selector(btnActEdit(_:)), for: .touchUpInside)
    }
}


extension profileInnerVC{
    @objc func btnActEdit(_ sender: UIButton){
        let vc = editProfileVC.instantiateFromAppStoryboard(appStoryboard: .Profile)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
