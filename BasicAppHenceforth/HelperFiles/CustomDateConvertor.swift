//
//  CustomDateConvertor.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 18/01/21.
//

import UIKit

enum DateForamaters : String {
    case API_DF = "yyyy-MM-ddThh:mm:ss.SSSZ"
    case joiningDF = "MMMM, yyyy"
}

class CustomDateConvertor : NSObject{
    
    // MARK: - SharedInstance
    class var shared: CustomDateConvertor{
        struct Singleton{
            static let instance = CustomDateConvertor()
        }
        return Singleton.instance
    }
    
    func getJoiningDate(_ date: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateForamaters.API_DF.rawValue
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        let kDate = dateFormatter.date(from: date)
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = DateForamaters.joiningDF.rawValue
        dateFormatter2.locale = Locale.current
        dateFormatter2.timeZone = TimeZone.current
        
        return dateFormatter2.string(from: kDate ?? Date())
    }
}
