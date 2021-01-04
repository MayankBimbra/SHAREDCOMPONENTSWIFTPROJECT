//
//  Extension+UIColor.swift
//  NewApp
//
//  Created by Think Recycling Pvt Ltd on 27/08/19.
//  Copyright © 2019 Think Recycling Pvt Ltd. All rights reserved.
//

import UIKit

extension UIColor{
    open class var themeColor : UIColor{
        get {
            return UIColor(named: "ThemeColor") ?? UIColor.green
        }
    }
    
    open class var themeUnSelectedColor : UIColor{
        get {
            return UIColor(named: "ThemeUnslectedColor") ?? UIColor.systemGreen
        }
    }

    open class var appWhiteColor : UIColor{
        get {
            return UIColor(named: "WhiteColor") ?? UIColor.white
        }
    }
    
    open class var appBlackColor : UIColor{
        get {
            return UIColor(named: "BlackColor") ?? UIColor.black
        }
    }
    
    open class var textColorMain : UIColor{
        get {
            return UIColor(named: "TextColorMain") ?? UIColor.black
        }
    }
    
    open class var textColorPlaceholder : UIColor{
        get {
            return UIColor(named: "TextColorPlaceholder") ?? UIColor.black
        }
    }
    
    open class var textColorOne : UIColor{
        get {
            return UIColor(named: "TextColorOne") ?? UIColor.black
        }
    }

    open class var textColorTwo : UIColor{
        get {
            return UIColor(named: "TextColorTwo") ?? UIColor.black
        }
    }
    
    open class var bGColor : UIColor{
        get {
            return UIColor(named: "BGColor") ?? UIColor.black
        }
    }

    open class var errorColor : UIColor{
        get {
            return UIColor(named: "RedColor") ?? UIColor.black
        }
    }

    open class var unreadColor : UIColor{
        get {
            return UIColor(named: "UnreadColor") ?? UIColor.black
        }
    }    
}

extension UIColor {
    // help in fetching color code throught Int
    convenience init(red: Int, green: Int, blue: Int, alpha: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        assert(alpha >= 0 && alpha <= 255, "Invalid alpha component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha) / 255.0)
    }
    
    // help in fetching color code throught Int
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 24) & 0xff, green:(netHex >> 16) & 0xff, blue:(netHex >> 8) & 0xff, alpha: netHex & 0xff)
    }
    
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
