import UIKit


internal var topStatusHeight : CGFloat{
    return UIApplication.shared.statusBarFrame.height
}

internal var bottomStatusHeight : CGFloat{
    if UIDevice.isBigIphone{
        return 34
    }else{
        return 4
    }
}

internal struct Languages {
    static let Arabic = "ar"
    static let English = "en"
}

// Screen width
public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width // current screen width
}

// Screen height
public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height // current screen height
}

//var industries : [IndustryAPIElement] = []
//var categoriesNew : [getCategories] = []
//var schoolStatic : [SchoolElement] = []
//var benifitsNew : [Benefit] = []



//struct Fonts {
//    struct ProximaNova {
//        internal static let Regular = "ProximaNova-regular"
//        internal static let Bold = "ProximaNova-bold"
//        internal static let Light = "ProximaNova-light"
//        internal static let SemiBold = "ProximaNova-Semibold"
//    }
//}


internal enum Colors : Int {
    case tfTextColor = 0x424142ff
    case RedColor = 0xF54540f
    //Horsebnb Color
    case btnborderColorbnb = 0x343A40ff
    case redColorLoginbnb = 0xDF3C47ff
    case colorChatBgColorbnb = 0xFAFAFAff
    case tfBorderColorbnb = 0xD8D8D8ff
    case btnBorderBlueColorBnb = 0x008489ff
    case btnBorderGrayBnb = 0x8C8E9099ff
    case bookingPendingColor = 0xCEAF08ff
    case bookingBlueColor = 0x3597DCff
    case bookingGreenColor = 0x15AA09ff
    case pendinfColorStatusBnb = 0xffc107ff
    case reviewExpireStatusBnb = 0xdc3545ff
    
    
    //Basic App Colors
    case greenThemeColor = 0x14AC63ff
    
    func color() -> UIColor {
        return UIColor(netHex: self.rawValue)
    }
}



