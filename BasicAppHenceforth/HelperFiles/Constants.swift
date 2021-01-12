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

var deviceInfo : DeviceInfo = DeviceInfo()

struct DeviceInfo {
    var deviceId : String = UIDevice.current.identifierForVendor!.uuidString
    var deviceType : String = "2"
    var fcmId : String = "Simulator"
}

class googleAuth {
    let googleClientKey : String = "580674692835-sohnkdhcfs343l8diam2r2npfjbq1tq0.apps.googleusercontent.com"
}
