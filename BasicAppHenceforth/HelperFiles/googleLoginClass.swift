//
//  googleLoginClass.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 12/01/21.
//

import UIKit
import GoogleSignIn

struct GoogleResult {
    
    var id: String?
    var name: String?
    var email: String?
    var firstName: String?
    var lastName: String?
    var profilePic: String?
    
    init(_ id: String?, name: String?, firstName: String?, lastName: String?, email: String?, profilePic: String?) {
        self.id = id
        self.name = name
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.profilePic = profilePic
    }
}

class googleLoginClass : NSObject, GIDSignInDelegate {
    
    
    
    typealias userResult = (GoogleResult) -> ()
    typealias errorResult = () -> ()
    
    var pickedListner : userResult?
    var removedListner : errorResult?
    
    var vc : UIViewController?

    
    class var shared: googleLoginClass {
        struct Static {
            static let instance = googleLoginClass()
        }
        return Static.instance
    }
    
    func googleLogin(_ view: UIViewController, success Success: @escaping userResult, failure Failure: @escaping errorResult){
        
        self.pickedListner = Success
        self.removedListner = Failure
        self.vc = view
        
        GIDSignIn.sharedInstance()?.presentingViewController = view
        GIDSignIn.sharedInstance()?.delegate = self

        GIDSignIn.sharedInstance().signIn()
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil{
            CommonFunctions.toster(error.localizedDescription)
            self.removedListner!()
        }else{
            let kNames = (user!.profile.name ?? "").split(separator: " ")
            
            var kFirstName = ""
            var kLastName = ""
            let profilePic = user.profile.imageURL(withDimension: 120)?.absoluteString
            
            if kNames.count == 1{
                kFirstName = String(kNames[0])
            }else if kNames.count > 1{
                kFirstName = String(kNames[0])
                kLastName = String(kNames[kNames.count - 1])
            }
            
            self.pickedListner!(GoogleResult.init(user!.userID, name: user!.profile.name ?? "", firstName: kFirstName, lastName: kLastName, email: user.profile.email, profilePic: profilePic))
            
            //self.hitLoginApi(params)
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        CommonFunctions.toster(error.localizedDescription)
        self.removedListner!()
    }
}
