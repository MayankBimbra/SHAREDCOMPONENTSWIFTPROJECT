//
//  homeVC.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 22/12/20.
//

import UIKit

class homeVC: UIViewController {

    // MARK: - UI COMPONENTS
    @IBOutlet weak var lblGdMorning: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgProfilePic: UIImageView!
    
    
    
    // MARK: - VARIABLES
    
    
    // MARK: - OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
    }
}


// MARK: - SET UP UI
extension homeVC{
    func setUpUI(){
        var currentTime = "Good Morning"
        let cDate = Date()
        let dateforatter = DateFormatter()
        dateforatter.dateFormat = "HH"
        dateforatter.locale = Locale(identifier: "en_US_POSIX")
        let hr = Int(dateforatter.string(from: cDate))!
        if hr > 3 && hr < 12{
            currentTime = "Good Morning"//, "
        }else if hr <= 3 || hr > 20{
            currentTime = "Good Night"
        }else if hr < 16{
            currentTime = "Good Afternoon"
        }else{
            currentTime = "Good Evening"
        }
        lblGdMorning.attributedText = CommonFunctions.sendAttText([currentTime, ", ", "John"], fonts: [UIFont.MontserratMedium(Size.Header.sizeValue()), UIFont.MontserratSemiBold(Size.Header.sizeValue()), UIFont.MontserratBold(Size.Header.sizeValue())], color: [UIColor.appWhiteColor, UIColor.appWhiteColor, UIColor.appWhiteColor], alingment: .left, spacing: 4)
        lblDescription.attributedText = CommonFunctions.sendAttText(["Lorem ipsum dolor sit amet, adipiscing elit."], fonts: [UIFont.MontserratRegular(Size.Medium.sizeValue())], color: [UIColor.appWhiteColor], alingment: .left, spacing: 4)
        imgProfilePic.layer.cornerRadius = 4
        
        
    }
}
