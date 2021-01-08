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
    let logoutURL = "logout"
    
    let getProfileURL = "profile"
    
    let notificationAPI = "notification"
    let chatListingAPI = "chat/listing"

}


enum  Image_Quality : String {
    case medium = "&folder=medium"
    case small = "&folder=small"
    case large = ""
}
