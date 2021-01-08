//
//  userData.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 05/01/21.
//

import UIKit
import CoreData

class userData: NSObject {
    
    var accessToken = ""
    
    var userId = 0
    var firstName = ""
    var lastName = ""
    var profileImage = ""
    var email = ""
    var fbId = ""
    var googleId = ""
    var appleId = ""
    var phoneNumber = 0
    var countryCode = ""
    var userDescription = ""
    var designation = ""
    
    var isEmailVerified = 0
    var isPhoneVerified = 0
    var isUserVerified = 0
    var isProfileCompleted = 0
    var userType = 0
    var dob = ""
    var isEmailNotified = 0
    var isPushNotified = 0
    var isSMSNotified = 0
    var status = 0

    
    class var shared: userData{
        struct singleTon {
            static let instance = userData()
        }
        return singleTon.instance
    }

    func fromSignUpData(_ data: SignUpAPI){
        self.accessToken = data.token ?? ""
        self.fromProfileData(data.user!)
    }

    
    func fromProfileData(_ data: User){
        
        self.userId = data.id ?? 0
        self.firstName = data.firstName ?? ""
        self.lastName = data.lastName ?? ""
        self.profileImage = data.profileImage ?? ""
        self.email = data.email ?? ""
        self.fbId = data.fbID ?? ""
        self.googleId = data.googleID ?? ""
        self.appleId = data.appleID ?? ""
        self.userDescription = data.userDescription ?? ""
        self.phoneNumber = data.phoneNumber ?? 0
        self.countryCode = data.countryCode ?? ""
        self.isEmailVerified = data.isEmailVerified ?? 0
        self.isPhoneVerified = data.isPhoneVerified ?? 0
        self.isUserVerified = data.isUserVerified ?? 0
        self.isProfileCompleted = data.isProfileCompleted ?? 0
        self.userType = data.userType ?? 0
        self.dob = data.dob ?? ""
        self.designation = data.designation ?? ""
        self.isEmailNotified = data.isEmailNotified ?? 0
        self.isPushNotified = data.isPushNotified ?? 0
        self.isSMSNotified = data.isSMSNotified ?? 0
        self.status = data.status ?? 0
        
        dataSave()
    }
    
    
    
    func dataSave(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "UserData"))
        
        do {
            try context.execute(DelAllReqVar)
        } catch {
            print(error)
        }
        let newData = NSEntityDescription.insertNewObject(forEntityName: "UserData", into: context)
        newData.setValue(accessToken, forKey: "accessToken")
        
        newData.setValue(userId, forKey: "userId")
        newData.setValue(firstName, forKey: "firstName")
        newData.setValue(lastName, forKey: "lastName")
        newData.setValue(email, forKey: "email")
        newData.setValue(profileImage, forKey: "profileImage")
        newData.setValue(countryCode, forKey: "countryCode")
        newData.setValue(phoneNumber, forKey: "phoneNumber")
        newData.setValue(fbId, forKey: "fbId")
        newData.setValue(googleId, forKey: "googleId")
        newData.setValue(appleId, forKey: "appleId")
        newData.setValue(userDescription, forKey: "userDescription")
        newData.setValue(designation, forKey: "designation")

        newData.setValue(dob, forKey: "dob")
        newData.setValue(isEmailVerified, forKey: "isEmailVerified")
        newData.setValue(isPhoneVerified, forKey: "isPhoneVerified")
        newData.setValue(isUserVerified, forKey: "isUserVerified")
        newData.setValue(isProfileCompleted, forKey: "isProfileCompleted")
        newData.setValue(userType, forKey: "userType")
        newData.setValue(isEmailNotified, forKey: "isEmailNotified")
        newData.setValue(isPushNotified, forKey: "isPushNotified")
        newData.setValue(isSMSNotified, forKey: "isSMSNotified")
        newData.setValue(status, forKey: "status")
        
        do {
            try context.save()
            print(newData)
            print("new data saved")
        }catch{
            print("new data save error")
        }
    }
    
    func deleteData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "UserData"))
        do {
            try context.execute(DelAllReqVar)
        } catch {
            print(error)
        }
    }
    
    func getData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
        request.returnsObjectsAsFaults = true
        do{
            let results = try context.fetch(request)
            if(results.count > 0){
                for result in results as![NSManagedObject]{
                    
                    if let accessToken = result.value(forKey: "accessToken") as? String{
                        self.accessToken = accessToken
                        print("data get accessToken \(accessToken)")
                    }
                    
                    if let userId = result.value(forKey: "userId") as? Int{
                        self.userId = userId
                        print("data get userId \(userId)")
                    }
                    
                    if let firstName = result.value(forKey: "firstName") as? String{
                        self.firstName = firstName
                        print("data get firstName \(firstName)")
                    }

                    if let lastName = result.value(forKey: "lastName") as? String{
                        self.lastName = lastName
                        print("data get lastName \(lastName)")
                    }

                    if let profileImage = result.value(forKey: "profileImage") as? String{
                        self.profileImage = profileImage
                        print("data get profileImage \(profileImage)")
                    }

                    if let email = result.value(forKey: "email") as? String{
                        self.email = email
                        print("data get email \(email)")
                    }
                    
                    if let fbId = result.value(forKey: "fbId") as? String{
                        self.fbId = fbId
                        print("data get fbId \(fbId)")
                    }

                    if let googleId = result.value(forKey: "googleId") as? String{
                        self.googleId = googleId
                        print("data get googleId \(googleId)")
                    }

                    if let appleId = result.value(forKey: "appleId") as? String{
                        self.appleId = appleId
                        print("data get appleId \(appleId)")
                    }

                    if let userDescription = result.value(forKey: "userDescription") as? String{
                        self.userDescription = userDescription
                        print("data get userDescription \(userDescription)")
                    }

                    if let phoneNumber = result.value(forKey: "phoneNumber") as? Int{
                        self.phoneNumber = phoneNumber
                        print("data get phoneNumber \(phoneNumber)")
                    }

                    if let countryCode = result.value(forKey: "countryCode") as? String{
                        self.countryCode = countryCode
                        print("data get countryCode \(countryCode)")
                    }

                    if let dob = result.value(forKey: "dob") as? String{
                        self.dob = dob
                        print("data get dob \(dob)")
                    }
                                            
                    if let isEmailVerified = result.value(forKey: "isEmailVerified") as? Int{
                        self.isEmailVerified = isEmailVerified
                        print("data get isEmailVerified \(isEmailVerified)")
                    }

                    if let isPhoneVerified = result.value(forKey: "isPhoneVerified") as? Int{
                        self.isPhoneVerified = isPhoneVerified
                        print("data get isPhoneVerified \(isPhoneVerified)")
                    }

                    if let isUserVerified = result.value(forKey: "isUserVerified") as? Int{
                        self.isUserVerified = isUserVerified
                        print("data get isUserVerified \(isUserVerified)")
                    }

                    if let isProfileCompleted = result.value(forKey: "isProfileCompleted") as? Int{
                        self.isProfileCompleted = isProfileCompleted
                        print("data get isProfileCompleted \(isProfileCompleted)")
                    }

                    if let userType = result.value(forKey: "userType") as? Int{
                        self.userType = userType
                        print("data get userType \(userType)")
                    }
                                            
                    if let isEmailNotified = result.value(forKey: "isEmailNotified") as? Int{
                        self.isEmailNotified = isEmailNotified
                        print("data get isEmailNotified \(isEmailNotified)")
                    }
                    
                    if let isPushNotified = result.value(forKey: "isPushNotified") as? Int{
                        self.isPushNotified = isPushNotified
                        print("data get isPushNotified \(isPushNotified)")
                    }
                    
                    if let isSMSNotified = result.value(forKey: "isSMSNotified") as? Int{
                        self.isSMSNotified = isSMSNotified
                        print("data get isSMSNotified \(isSMSNotified)")
                    }

                    if let status = result.value(forKey: "status") as? Int{
                        self.status = status
                        print("data get status \(status)")
                    }
                }
            }
        } catch {
            print("something error during getting data")
        }
    }
    
}
