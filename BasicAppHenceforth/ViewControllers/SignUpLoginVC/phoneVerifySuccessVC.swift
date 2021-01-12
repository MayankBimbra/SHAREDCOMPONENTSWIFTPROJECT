//
//  phoneVerifySuccessVC.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 21/12/20.
//

import UIKit

class phoneVerifySuccessVC: UIViewController {

    // MARK: - UI COMPONENTS
    
    
    
    // MARK: - VARIABLES
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var lblDisplay: UILabel!
    @IBOutlet weak var viewCheckmark: checkmarkView!
    
    
    
    
    // MARK: - OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
}


// MARK: - SET UP UI
extension phoneVerifySuccessVC{
    func setUpUI(){
        viewCheckmark.animated = true
        outerView.isHidden = true
        lblDisplay.isHidden = true
        self.viewCheckmark.animate(duration: 0.4)

        lblDisplay.attributedText = CommonFunctions.sendAttText([L10n.PhoneNumberSuccessfulFirst.description, L10n.PhoneNumberSuccessfulLast.description], fonts: [UIFont.MontserratMedium(Size.Large.sizeValue()), UIFont.MontserratBold(Size.Large.sizeValue())], color: [UIColor.textColorOne, UIColor.textColorOne], alingment: .center)
        
        outerView.layer.cornerRadius = outerView.frame.height/2
        innerView.layer.cornerRadius = innerView.frame.height/2
        
        UIView.animate(withDuration: 0.4) {
//            self.innerView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            self.outerView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        } completion: { _ in
            self.outerView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.outerView.isHidden = false
            self.lblDisplay.isHidden = false
            self.lblDisplay.alpha = 0
            UIView.animate(withDuration: 0.5) {
                self.lblDisplay.alpha = 1
                self.innerView.transform = CGAffineTransform(scaleX: 1, y: 1)
                
                self.outerView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)

            } completion: { _ in
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    let vc = tabbarVC.instantiateFromAppStoryboard(appStoryboard: .Tabbar)
                    self.navigationController?.pushViewController(vc, animated: false)
                }
            }
        }
    }
}
