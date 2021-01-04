
import UIKit
import GooglePlaces
//import GoogleMaps

struct loc {
    var lat: Double
    var lng: Double
    var name: String
    var fullAddress: String
    
    init(_ lat: Double, lng: Double, name: String, fullAddress: String) {
        self.lat = lat
        self.lng = lng
        self.name = name
        self.fullAddress = fullAddress
    }
//    let remloc = ()
}



class findLocation: NSObject, GMSAutocompleteViewControllerDelegate{
    
    typealias picklocation = (loc) -> ()
    typealias removelocation = () -> ()
    
    var pickedListner : picklocation?
    var removedListner : removelocation?
    
    var vc : UIViewController?

    
    class var sharedInstance: findLocation {
        struct Static {
            static let instance = findLocation()
        }
        return Static.instance
    }

    
    func pickerLocation(presentInVc : UIViewController, countryUs : Bool , pickedListner : @escaping picklocation , removedListner : @escaping removelocation){
        
//        presentInVc = VC
        self.pickedListner = pickedListner
        self.removedListner = removedListner
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        vc = autocompleteController

        if countryUs{
            let filter = GMSAutocompleteFilter()
            filter.countries = ["US"]
            filter.type = .address
            autocompleteController.autocompleteFilter = filter
        }
//        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
//            UInt(GMSPlaceField.placeID.rawValue))!
//        autocompleteController.placeFields = fields
//
//        // Specify a filter.
//        let filter = GMSAutocompleteFilter()
//        filter.type = .address
//        autocompleteController.autocompleteFilter = filter

        presentInVc.present(autocompleteController, animated: true, completion: nil)
    }
    
//    func picloc(_ pic: picklocation, source: GMSAutocompleteViewController){
//                UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [.foregroundColor: UIColor.white]
////                d(autocompleteController, animated: true, completion: nil)
//    }
//
//    func remLoc(_ pic2: removelocation, source: GMSAutocompleteViewController){
//        autocompleteController.delegate = self
//        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [.foregroundColor: UIColor.white]
//    }
    

    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: ",place.name as Any)
        print("Place name: ",place.placeID as Any)
        print("Place name: ",place.attributions as Any)
        if(place.formattedAddress != nil){
            print(place.formattedAddress!)
            let loca = loc.init(place.coordinate.latitude, lng: place.coordinate.longitude, name: place.name!, fullAddress: place.formattedAddress!)
            pickedListner!(loca)
        }
        vc?.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        if let listener = removedListner{
            listener()
        }
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        vc?.dismiss(animated: true, completion: nil)
        if let listener = removedListner{
            listener()
        }
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
