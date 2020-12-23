//
//  SplashScreenCVC.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 11/12/20.
//

import UIKit

class SplashScreenCVC: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblSubHeader: UILabel!
    
    func setData(_ data : SplashScreenData){
        imgView.contentMode = .scaleAspectFit
        lblHeader.font = UIFont.MontserratSemiBold(Size.Header.sizeValue())
        lblSubHeader.font = UIFont.MontserratMedium(Size.Medium.sizeValue())
        
        lblHeader.textColor = UIColor.themeColor
        lblSubHeader.textColor = UIColor.black

        lblHeader.text = data.title
        lblSubHeader.text = data.subTitle
        imgView.image = data.image
    }
}
