//
//  fbLoginClass.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 11/01/21.
//

import UIKit
import FacebookCore
import FacebookLogin
import FacebookShare

struct FBResult {
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

class fbLoginClass {
    
    class func facebookLogin(view:UIViewController,success Success: @escaping (_ result : FBResult) -> Void, failure Failure: @escaping(_ error : [String: AnyObject]) -> Void) {
        let fbLogin : LoginManager = LoginManager()
        fbLogin.logOut()
        //  let loadingOverlay = loadingOnScreen(self.view.frame)
        // self.view.addSubview(loadingOverlay)
        
        fbLogin.logIn(permissions: ["email","public_profile"], from: view) { (result, err) in
            if(err != nil){
                Failure([:])
                print("custom fb login failed",err as Any)
                // loadingOverlay.removeFromSuperview()
                return
            }
            if (result?.isCancelled)!{
                Failure([:])
                // loadingOverlay.removeFromSuperview()
                return
            }
            print("picv",result as Any)
            self.getFacebookUserInfo(success: { (result) in
                Success(result)
            })
            // self.dataGettingFromFB(fbLogin, loadingOverlay: loadingOverlay)
            print(result?.token?.tokenString ?? "error")
            //
        }
    }
    
    class func getFacebookUserInfo(success Success: @escaping (_ result : FBResult) -> Void) {
        if(AccessToken.current != nil) {
            //print permissions, such as public_profile
            //print(AccessToken.current.permissions)
            let graphRequest = GraphRequest(graphPath: "me", parameters: ["fields" : "id, name, email,first_name,last_name"])
            let connection = GraphRequestConnection()
            
            connection.add(graphRequest, completionHandler: { (connection, result, error) -> Void in
                if result != nil {
                    let data = result as! [String : AnyObject]
                    print("data",data as Any)
                    // self.label.text = data["name"] as? String
                    let FBid = data["id"] as? String
                    let url = NSURL(string: "https://graph.facebook.com/\(FBid!)/picture?type=large&return_ssl_resources=1")
                    print("url",url as Any)
                    let fbImg = "https://graph.facebook.com/\(FBid!)/picture?type=large&return_ssl_resources=1"
                    Success(FBResult.init(FBid, name: data["name"] as? String, firstName: data["first_name"] as? String, lastName: data["last_name"] as? String, email: data["email"] as? String, profilePic: fbImg))
                } else{
                    
                }
                
                //  self.imageView.image = UIImage(data: NSData(contentsOf: url! as URL)! as Data)
            })
            connection.start()
        }
    }
}
