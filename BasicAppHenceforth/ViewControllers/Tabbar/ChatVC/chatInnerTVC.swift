//
//  chatInnerLeftTVC.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 28/12/20.
//

import UIKit

class chatBaseTVC: UITableViewCell {
    
    var lngPressGest : UILongPressGestureRecognizer = UILongPressGestureRecognizer()
    var tapPressGest : UITapGestureRecognizer = UITapGestureRecognizer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.addGestureRecognizer(lngPressGest)
        self.contentView.addGestureRecognizer(tapPressGest)
        self.contentView.isUserInteractionEnabled = true
    }
    
    func onSelected(_ ifSelected: Bool){
        if ifSelected{
            self.contentView.backgroundColor = UIColor.unreadColor
        }else{
            self.contentView.backgroundColor = UIColor.appWhiteColor
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

class chatBaseTextTVC: chatBaseTVC {
    
    var lblBaseMsg : UILabel!
    var lblBaseTime : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        lblBaseMsg.font = UIFont.MontserratSemiBold(Size.Medium.sizeValue())
        lblBaseTime.font = UIFont.MontserratSemiBold(Size.VSmall.sizeValue())
        lblBaseTime.textColor = UIColor.textColorTwo
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

class chatInnerLeftTVC: chatBaseTextTVC {
    
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var viewOuter: UIView!
    
    
    override func awakeFromNib() {
        lblBaseMsg = lblMsg
        lblBaseTime = lblTime
        super.awakeFromNib()
        lblMsg.textColor = UIColor.appBlackColor
        lblMsg.text = "Hello?. How are you? When you will free to check?"
        lblTime.text = "10:00AM"
    }
}

class chatInnerRightTVC: chatBaseTextTVC {

    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var viewOuter: UIView!
    
    override func awakeFromNib() {
        lblBaseMsg = lblMsg
        lblBaseTime = lblTime
        super.awakeFromNib()
        lblMsg.textColor = UIColor.appWhiteColor
        lblMsg.text = "Hello, how are you?"
        lblTime.text = "10:00AM"
    }
}





class leftView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()

        self.roundCorners([.topLeft, .topRight, .bottomRight], radius: 8)
    }
}

class rightView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()

        self.roundCorners([.topLeft, .topRight, .bottomLeft], radius: 8)
    }
}
