//
//  Fonts.swift
//  Lowicks
//
//  Created by MAC on 03/09/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import UIKit

internal enum Size : CGFloat{
    
    case Small = 12.0
    case Medium = 14.0
    case Large = 16.0
    case XLarge = 18.0
    case XXXLarge = 22.0

    case Header = 20.0

    func sizeValue() -> CGFloat{
        return self.rawValue
    }
}

extension UIFont {
    class func MontserratRegular(_ size:CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Regular", size: size)!
    }

    class func MontserratMedium(_ size:CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Medium", size: size)!
    }
    
    class func MontserratSemiBold(_ size:CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-SemiBold", size: size)!
    }

    class func MontserratBold(_ size:CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Bold", size: size)!
    }

    class func NexaBold(_ size:CGFloat) -> UIFont {
        return UIFont(name: "Nexa Bold", size: size)!
    }
    
    class func NexaLight(_ size:CGFloat) -> UIFont {
        return UIFont(name: "Nexa Light", size: size)!
    }
}
