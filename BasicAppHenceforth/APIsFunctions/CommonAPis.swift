import Foundation
import UIKit

class appConstantURL{
    
    let BASE_URL = "https://app-transfer.com:3006/api/"

    let signUpURL = "signup"
    let resendPhoneVerifyURL = "resend/verification-phone"
    let verifyPhoneURL = "verify/phone"
    let loginURL = "login"
    let forgotURL = "forgot/password"
    let changePassowrdURL = "change/password"
    let contactUsURL = "contact-us"
    let resetNotificationsURL = "reset/notifications"
    let contentDataURL = "content"
    let getProfileURL = "profile"
    let editProfileURL = "profile"
    let logoutURL = "logout"

    let notificationAPI = "notification"
    let chatListingAPI = "chat/listing"
    let chatIntListingAPI = "chat/messages"
    
    let uploadImageURL = "upload/local"
}


enum Image_Quality : String {
    case medium = "&folder=medium"
    case small = "&folder=small"
    case large = "&folder=orig"
}
