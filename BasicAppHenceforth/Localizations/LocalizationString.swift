//
//  LocalizationString.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 11/12/20.
//

import Foundation

enum L10n {
    // Walkthrough Screens
    case SKIP
    case REGISTER
    case SIGNIN
    case Splash1Header
    case Splash2Header
    case Splash3Header
    case Splash1Detail
    case Splash2Detail
    case Splash3Detail
    
    // Register Screens
    case CreateNewAccount
    case AlreadyAccount
    case AlreadyAccountLogin
    case FirstName
    case LastName
    case Email
    case Password
    case ConfirmPassword
    case PhoneNumber
    case TermsCond1
    case TermsCond2
    case TermsCond3
    case TermsCond4

    // Phone Verification
    case PhoneNumberVerification
    case EnterCodeVerification
    case EnterWrongOTP
    case DidntReceiveCode
    case SendAgain
    case Next

    // pone number successful screen
    case PhoneNumberSuccessfulFirst
    case PhoneNumberSuccessfulLast
    
    // Login Screen
    case WelcomeBack
    case PleaseLogInToYourAccount
    case ForgetPassword
    case DontHaveAcc
    case SignUp
    case Log_In

    // Forgot Password
    case ForgotPasswordTitle
    case ForgotPasswordDesc
    case SUBMIT
    
    // SignUp PopUp
    case SignPopUpHeader
    case SignPopUpDecs
    case SignPopUpOr
    case SignPopUpSignUp

    // CHAT SCREEN
    case ChatHeader
    case TypeMessage
    case Camera
    case Gallery
    case Location
    case Cancel
    
    // NOTIFICATION
    case NotificationHeader

    // PROFILE
    case SETTING
    case ShowProfile
    case ACCOUNT_SETTINGS
    case Personal_Information
    case Notifications
    case Change_Password
    case Language
    case SUPPORT
    case Contact_Us
    case Help_Center
    case About_Us
    case FEEDBACK
    case Rate_App
    case Share_App
    case LEGAL
    case Privacy_Policy
    case Terms_and_Conditions
    case Log_Out
    case AppVeriosn

    // Profile Inner Screen
    case PROFILE
    case HiText
    case JoinedText
    case AboutText
    case Business
    
    // Edit Profile
    case EditProfile
    case SAVE
    case Verify
    case TellUsAboutYoursef
    
    // Notification
    case EmailNot
    case PushNotification
    case PushNotificationDesc
    
    // change password
    case OldPassword
    case NewPassword
    case UpdatePassword
    
    // contact us
    case Name
    case Message
    
    // logout popUp
    case LogOutDesc
    case Yes
    case No
    
    case InternetNotAvailable
    
    // ERRORS
    case PleaseEnterFirstName
    case PleaseEnterLastName
    case PleaseEnterEmail
    case PleaseEnterValidEmail
    case PleaseEnterPassword
    case PleaseEnterValidPassword
    case PleaseEnterConfirmPassword
    case PleaseEnterSamePassword
    case PleaseEnterPhoneNumber
    case PleaseEnterValidPhoneNumber
}


extension L10n: CustomStringConvertible{
    var description: String{ return self.string }
    
    var string: String{
        switch self {
        case .SKIP:
            return L10n.tr("SKIP")
        case .REGISTER:
            return L10n.tr("SIGN UP")
        case .SIGNIN:
            return L10n.tr("SIGN IN")
        case .Splash1Header:
            return L10n.tr("Welcome")
        case .Splash2Header:
            return L10n.tr("Friendly Work Environment")
        case .Splash3Header:
            return L10n.tr("Join Our Team")
        case .Splash1Detail:
            return L10n.tr("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ut purus et massa porta aliquet.")
        case .Splash2Detail:
            return L10n.tr("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ut purus et massa porta aliquet.")
        case .Splash3Detail:
            return L10n.tr("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur ut purus et massa porta aliquet.")
        case .CreateNewAccount:
            return L10n.tr("Create New Account")
        case .AlreadyAccount:
            return L10n.tr("Already have an account ?")
        case .AlreadyAccountLogin:
            return L10n.tr(" Sign In")
        case .FirstName:
            return L10n.tr("First Name")
        case .LastName:
            return L10n.tr("Last Name")
        case .Email:
            return L10n.tr("Email")
        case .Password:
            return L10n.tr("Password")
        case .ConfirmPassword:
            return L10n.tr("Confirm Password")
        case .PhoneNumber:
            return L10n.tr("Phone Number")
        case .PhoneNumberVerification:
            return L10n.tr("Phone Number Verification")
        case .EnterCodeVerification:
            return L10n.tr("Enter the verification code just sent to ")
        case .EnterWrongOTP:
            return L10n.tr("Oh no ! You entered wrong OTP code please check it again.")
        case .DidntReceiveCode:
            return L10n.tr("Didn't receive code? ")
        case .SendAgain:
            return L10n.tr("Send again")
        case .Next:
            return L10n.tr("NEXT")
        case .PhoneNumberSuccessfulFirst:
            return L10n.tr("Your phone number verified ")
        case .PhoneNumberSuccessfulLast:
            return L10n.tr("successfully!")

        case .TermsCond1:
            return L10n.tr("By creating an account you agree with our ")
        case .TermsCond2:
            return L10n.tr("Terms of Service")
        case .TermsCond3:
            return L10n.tr(" and ")
        case .TermsCond4:
            return L10n.tr("Privacy Policy")

        case .WelcomeBack:
            return L10n.tr("Welcome Back")
        case .PleaseLogInToYourAccount:
            return L10n.tr("Please log in to your account.")
        case .ForgetPassword:
            return L10n.tr("Forget Password?")
        case .DontHaveAcc:
            return L10n.tr("Don't have account? ")
        case .SignUp:
            return L10n.tr("Sign Up")
        case .Log_In:
            return L10n.tr("LOGIN")
            
        case .ForgotPasswordTitle:
            return L10n.tr("Forget Password")
        case .ForgotPasswordDesc:
            return L10n.tr("Please enter your registered email id we will send a link to your email.")
        case .SUBMIT:
            return L10n.tr("SUBMIT")
        case .SignPopUpHeader:
            return L10n.tr("Want to see more of app functionality")
        case .SignPopUpDecs:
            return L10n.tr("Please Log in to your account or sign up.")
        case .SignPopUpOr:
            return L10n.tr("OR")
        case .SignPopUpSignUp:
            return L10n.tr("SIGN UP")
            
        case .ChatHeader:
            return L10n.tr("Chats")
        case .TypeMessage:
            return L10n.tr("Type message...")
        case .Camera:
            return L10n.tr("Camera")
        case .Gallery:
            return L10n.tr("Gallery")
        case .Location:
            return L10n.tr("Location")
        case .Cancel:
            return L10n.tr("Cancel")

        case .NotificationHeader:
            return L10n.tr("Alerts")

        case .SETTING:
            return L10n.tr("Settings")
        case .PROFILE:
            return L10n.tr("Profile")
        case .ShowProfile:
            return L10n.tr("Show Profile")
        case .ACCOUNT_SETTINGS:
            return L10n.tr("ACCOUNT SETTINGS")
        case .Personal_Information:
            return L10n.tr("Personal Information")
        case .Notifications:
            return L10n.tr("Notifications")
        case .Change_Password:
            return L10n.tr("Change Password")
        case .Language:
            return L10n.tr("Language")
        case .SUPPORT:
            return L10n.tr("SUPPORT")
        case .Contact_Us:
            return L10n.tr("Contact Us")
        case .Help_Center:
            return L10n.tr("Help Center")
        case .About_Us:
            return L10n.tr("About Us")
        case .FEEDBACK:
            return L10n.tr("FEEDBACK")
        case .Rate_App:
            return L10n.tr("Rate App")
        case .Share_App:
            return L10n.tr("Share App")
        case .LEGAL:
            return L10n.tr("LEGAL")
        case .Privacy_Policy:
            return L10n.tr("Privacy Policy")
        case .Terms_and_Conditions:
            return L10n.tr("Terms and Conditions")
        case .Log_Out:
            return L10n.tr("Log Out")
        case .AppVeriosn:
            return L10n.tr("APP VERSION 1.0")
            
        case .HiText:
            return L10n.tr("Hi, I'm ")
        case .JoinedText:
            return L10n.tr("Joined in ")
        case .AboutText:
            return L10n.tr("About")
        case .Business:
            return L10n.tr("Work")
            
        case .EditProfile:
            return L10n.tr("Edit Profile")
        case .SAVE:
            return L10n.tr("SAVE")
        case .Verify:
            return L10n.tr("Verify")
        case .TellUsAboutYoursef:
            return L10n.tr("Tell us about yourself...")
        case .EmailNot:
            return L10n.tr("Email")
        case .PushNotification:
            return L10n.tr("Push notifications")
        case .PushNotificationDesc:
            return L10n.tr("Receive message on your mobile or tablet device.")

        case .OldPassword:
            return L10n.tr("Old Password")
        case .NewPassword:
            return L10n.tr("New Password")
        case .UpdatePassword:
            return L10n.tr("Update Password")
            
        case .Name:
            return L10n.tr("Name")
        case .Message:
            return L10n.tr("Message")

        case .LogOutDesc:
            return L10n.tr("Are you sure you want to logout?")
        case .Yes:
            return L10n.tr("Yes")
        case .No:
            return L10n.tr("No")

        case .InternetNotAvailable:
            return L10n.tr("Internet Not Available")

        case .PleaseEnterFirstName:
            return L10n.tr("Please Enter First Name")
        case .PleaseEnterLastName:
            return L10n.tr("Please Enter Last Name")
        case .PleaseEnterEmail:
            return L10n.tr("Please Enter Email")
        case .PleaseEnterValidEmail:
            return L10n.tr("Please Enter Valid Email")
        case .PleaseEnterPassword:
            return L10n.tr("Please Enter Password")
        case .PleaseEnterValidPassword:
            return L10n.tr("Please Enter Valid Password")
        case .PleaseEnterConfirmPassword:
            return L10n.tr("Please Enter Confirm Password")
        case .PleaseEnterSamePassword:
            return L10n.tr("Password Should Be Same")
        case .PleaseEnterPhoneNumber:
            return L10n.tr("Please Enter Phone Number")
        case .PleaseEnterValidPhoneNumber:
            return L10n.tr("Please Enter Valid Phone Number")

        }
    }
    
    private static func tr(_ key: String, _ args: CVarArg...) -> String{
        let format = NSLocalizedString(key, comment: "")
        return format
//        return String(format: format, locale: Locale.current, arguments: args)
    }
}

func tr(key: L10n) -> String{
    return key.string
}
