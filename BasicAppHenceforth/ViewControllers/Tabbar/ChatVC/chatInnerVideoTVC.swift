//
//  chatInnerVideoTVC.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 02/01/21.
//

import UIKit

class chatBaseVideoPhotoTVC: chatBaseTVC {
    
    var imgViewBasePic : UIImageView!
    var btnBasePic : UIButton!
    var lblBaseTime : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblBaseTime.font = UIFont.MontserratSemiBold(Size.VSmall.sizeValue())
        lblBaseTime.textColor = UIColor.textColorTwo
        imgViewBasePic.layer.cornerRadius = 8
    }
    
    func forVideo(){
        btnBasePic.setImage(Asset.ic_Play_Circle_Outline.image(), for: .normal)
        btnBasePic.tintColor = UIColor.white
    }
    
    func forPicture(){
        btnBasePic.setImage(nil, for: .normal)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

class chatInnerVideoLeftTVC: chatBaseVideoPhotoTVC {

    @IBOutlet weak var imgViewPic: UIImageView!
    @IBOutlet weak var btnPic: UIButton!
    @IBOutlet weak var lblTime: UILabel!
    
    override func awakeFromNib() {
        imgViewBasePic = imgViewPic
        btnBasePic = btnPic
        lblBaseTime = lblTime
        super.awakeFromNib()
        lblTime.text = "10:00AM"
    }
}


class chatInnerVideoRightTVC: chatBaseVideoPhotoTVC {
    
    @IBOutlet weak var imgViewPic: UIImageView!
    @IBOutlet weak var btnPic: UIButton!
    @IBOutlet weak var lblTime: UILabel!
    
    override func awakeFromNib() {
        imgViewBasePic = imgViewPic
        btnBasePic = btnPic
        lblBaseTime = lblTime
        super.awakeFromNib()
        lblTime.text = "10:00AM"
    }
}
