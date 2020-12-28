//
//  webPageVC.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 23/12/20.
//

import UIKit

enum WebPageType : String {
    case AboutUs = "About Us"
    case PrivacyPolicy = "Privacy Policy"
    case TermsAndCond = "Terms and Conditions"
}

class webPageVC: headerVC {

    // MARK: - UI COMPONENTS
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var lblData: UILabel!
    
    
    // MARK: - VARIABLES
    var screenType : WebPageType = .AboutUs
    
    
    
    // MARK: - OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        isBackEnabled = true
        super.viewDidLoad()

        self.lblHeader.text = screenType.rawValue

        if screenType == .AboutUs{
            viewImage.isHidden = false
            lblData.text = "This is about Us text"
            imgView.backgroundColor = .bGColor
        }else if screenType == .PrivacyPolicy{
            viewImage.isHidden = true
            lblData.text = "This is privacy policy text"
        }else{
            viewImage.isHidden = true
            lblData.text = "This is Terms and Condition text"
        }
    }
}
