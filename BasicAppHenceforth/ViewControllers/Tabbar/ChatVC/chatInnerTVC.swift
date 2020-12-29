//
//  chatInnerLeftTVC.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 28/12/20.
//

import UIKit

class chatInnerLeftTVC: UITableViewCell {
    
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var viewOuter: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblMsg.font = UIFont.MontserratSemiBold(Size.Medium.sizeValue())
        lblTime.font = UIFont.MontserratSemiBold(Size.VSmall.sizeValue())
        lblMsg.textColor = UIColor.appBlackColor
        lblTime.textColor = UIColor.textColorTwo
        
        lblMsg.text = "Hello?. How are you? When you will free to check?"
        lblTime.text = "10:00AM"
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}



class chatInnerRightTVC: UITableViewCell {

    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var viewOuter: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        lblMsg.font = UIFont.MontserratSemiBold(Size.Medium.sizeValue())
        lblTime.font = UIFont.MontserratSemiBold(Size.VSmall.sizeValue())
        lblMsg.textColor = UIColor.appWhiteColor
        lblTime.textColor = UIColor.textColorTwo
        
        lblMsg.text = "Hello, how are you?"
        lblTime.text = "10:00AM"

//        viewOuter.roundCorners([.topLeft, .topRight, .bottomLeft], radius: 4)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
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
