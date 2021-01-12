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
    var webPageVM : WebPageVM = WebPageVM.shared
    
    
    // MARK: - OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        isBackEnabled = true
        super.viewDidLoad()
        
        webPageVM.controller = self
        
        viewImage.isHidden = true
        lblData.isHidden = true

        self.lblHeader.text = screenType.rawValue

        webPageVM.getContentDataAPI()        
    }
}
