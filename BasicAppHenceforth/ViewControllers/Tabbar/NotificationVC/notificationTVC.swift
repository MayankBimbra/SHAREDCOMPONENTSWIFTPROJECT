//
//  notificationTVC.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 22/12/20.
//

import UIKit

class notificationTVC: UITableViewCell {

    @IBOutlet weak var imgViewNotify: UIImageView!
    @IBOutlet weak var viewUnread: UIView!
    @IBOutlet weak var lblNotification: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewUnread.layer.cornerRadius = viewUnread.frame.height/2
        imgViewNotify.layer.cornerRadius = imgViewNotify.frame.height/2
        imgViewNotify.layer.borderWidth = 1
        
        lblDate.font = UIFont.MontserratMedium(Size.Small.sizeValue())
        lblDate.textColor = UIColor.textColorTwo

//        lblNotification.text = "Lorem ipsum dolor sit amet adipiscing elit. Etiam sodales metus. dsfsfds fsfsfdsfsdfsfd sdfsf dsf sdf sdf dsfsdfs dfsf s"
//        lblDate.text = "Today"
        
        // Initialization code
    }

    func cellUnread(){
        lblNotification.font = UIFont.MontserratSemiBold(Size.Large.sizeValue())
        lblNotification.textColor = UIColor.appBlackColor
        self.contentView.backgroundColor = UIColor.unreadColor
        imgViewNotify.layer.borderColor = UIColor.themeColor.cgColor
        viewUnread.isHidden = false
    }
    
    func cellRead(){
        lblNotification.font = UIFont.MontserratMedium(Size.Large.sizeValue())
        lblNotification.textColor = UIColor.textColorOne
        self.contentView.backgroundColor = UIColor.appWhiteColor
        imgViewNotify.layer.borderColor = UIColor.bGColor.cgColor
        viewUnread.isHidden = true
    }
    
    func setData(_ data : NotificationC){
        if data.isRead == 1{
            cellRead()
        }else{
            cellUnread()
        }
        lblNotification.text = data.title
        lblDate.text = data.timeSince
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
