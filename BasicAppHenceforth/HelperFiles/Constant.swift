//
//  Constant.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 11/12/20.
//

import Foundation

enum CollectionViewCell : String{
    case SplashScreenCVC = "SplashScreenCVC"
    
    func getValues() -> String{
        return self.rawValue
    }
}

enum TableViewCell : String{
    case notificationTVC = "notificationTVC"
    case chatTVC = "chatTVC"
    case chatInnerLeftTVC = "chatInnerLeftTVC"
    case chatInnerRightTVC = "chatInnerRightTVC"

    func getValues() -> String{
        return self.rawValue
    }
}
