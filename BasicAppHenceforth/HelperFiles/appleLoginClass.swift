//
//  appleLoginClass.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 12/01/21.
//

import UIKit
import AuthenticationServices

struct AppleResult {
    
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

@available(iOS 13.0, *)
class appleLoginClass : NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    typealias userResult = (AppleResult) -> ()
    typealias errorResult = () -> ()
    
    var pickedListner : userResult?
    var removedListner : errorResult?
    
    var vc : UIViewController?

    
    class var shared: appleLoginClass {
        struct Static {
            static let instance = appleLoginClass()
        }
        return Static.instance
    }
    
    func appleLogin(_ view: UIViewController, success Success: @escaping userResult, failure Failure: @escaping errorResult){
        
        self.pickedListner = Success
        self.removedListner = Failure
        self.vc = view
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
            
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
        
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        CommonFunctions.toster(error.localizedDescription)
        self.removedListner!()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        var id : String?
        var name : String?
        var email : String?
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                    // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let userFirstName = appleIDCredential.fullName?.givenName
            let userLastName = appleIDCredential.fullName?.familyName
            let userEmail = appleIDCredential.email

            id = appleIDCredential.user
            name = appleIDCredential.fullName?.givenName
            email = appleIDCredential.email

            print(userIdentifier, userFirstName, userLastName, userEmail)
            
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            print(username, password)
            //Navigate to other view controller
        }
        
        if email != nil{
            if email != ""{
                email = email! as String
            }
        }
        
        if name != nil{
            if name != ""{
                name = name! as String
            }
        }

        let kNames = (name ?? "").split(separator: " ")
       
        var kFirstName = ""
        var kLastName = ""

        if kNames.count == 1{
            kFirstName = String(kNames[0])
        }else if kNames.count > 1{
            kFirstName = String(kNames[0])
            kLastName = String(kNames[kNames.count - 1])
        }
        
        self.pickedListner!(AppleResult.init(id, name: name ?? "", firstName: kFirstName, lastName: kLastName, email: email, profilePic: nil))
        
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.vc!.view.window!
    }
}
