//
//  chatTVC.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 22/12/20.
//

import UIKit
import YYWebImage

class chatTVC: UITableViewCell {

    @IBOutlet weak var imgViewDP: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var viewUnread: UIView!
    @IBOutlet weak var lblUnread: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgViewDP.layer.cornerRadius = imgViewDP.frame.height/2
        imgViewDP.clipsToBounds = true
        imgViewDP.contentMode = .scaleAspectFill
        viewUnread.layer.cornerRadius = viewUnread.frame.height/2
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.viewUnread.layer.cornerRadius = self.viewUnread.frame.height/2
        }
        lblName.font = UIFont.MontserratSemiBold(Size.Large.sizeValue())
        lblName.textColor = UIColor.appBlackColor
        
        lblDate.font = UIFont.MontserratMedium(Size.Small.sizeValue())

        lblMsg.font = UIFont.MontserratMedium(Size.Small.sizeValue())

        lblUnread.font = UIFont.MontserratBold(Size.Small.sizeValue())
        lblUnread.textColor = UIColor.appWhiteColor

        // Initialization code
    }

    func setData(_ data: ChatAPIElement){
        lblName.text = "\(data.firstName ?? "") \(data.lastName ?? "")"
        imgViewDP.yy_setImage(with: URL(string: CommonFunctions.getImage(data.profileImage ?? "", quality: .small)), placeholder: nil)
        lblDate.text = data.timeSince ?? ""
        lblMsg.text = data.message
        if data.isRead ?? 0 == 1{
            cellRead()
        }else{
            cellUnread(data.unreadCount ?? 0)
        }
    }
    
    func cellUnread(_ num: Int){
        lblDate.textColor = UIColor.appBlackColor
        lblMsg.textColor = UIColor.appBlackColor
        viewUnread.isHidden = false
        lblUnread.text = "\(num)"
        self.contentView.backgroundColor = UIColor.unreadColor
    }
    
    func cellRead(){
        lblDate.textColor = UIColor.textColorTwo
        lblMsg.textColor = UIColor.textColorOne
        viewUnread.isHidden = true
        lblUnread.text = "0"
        self.contentView.backgroundColor = UIColor.appWhiteColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
