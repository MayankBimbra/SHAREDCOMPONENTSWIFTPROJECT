import Foundation
import UIKit
//
//
//// dev
let BASE_URL = "https://flex-api.sharetribe.com"
//let BASE_URL = "http://178.62.41.249:8000/api/"
//
//// stag
////let BASE_URL = "http://13.59.202.73:8001/api/"
////let BASE_URL = "http://178.62.41.249:8001/api/"
//
////live
////let BASE_URL = "https://www.lowicks.com:8002/api/"
//
////local
////let BASE_URL = "http://192.168.1.184:8001/api/"


let device_type = "2"
let device_id = UIDevice.current.identifierForVendor!.uuidString
var device_token = "xyz"
var identifier = "asdfghjklasdfghj"


var appDelegate : AppDelegate!
var monthsData : VAMonth!


//func deleteData(){
//    coredata.shared.accesstoken = ""
//    coredata.shared.dataSave()
//}

enum  Image_Quality : String {
    case medium = "&folder=medium"
    case small = "&folder=small"
    case large = ""
}
