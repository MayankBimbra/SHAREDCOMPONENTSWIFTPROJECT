//
//  LocationServices.swift
//  PGRaters
//
//  Created by MAC on 09/08/19.
//  Copyright © 2019 Henceforth. All rights reserved.
//

import Foundation
import GoogleMaps
import Alamofire

typealias JSONDictionary = [String:Any]

class LocationServices: NSObject, CLLocationManagerDelegate {
    
    //    let shared = LocationServices()
    let locManager = CLLocationManager()
    var currentLocation: CLLocation!
    var cancelled : Bool = false
    
    var authStatus = CLLocationManager.authorizationStatus()
    var inUse = CLAuthorizationStatus.authorizedWhenInUse
    var always = CLAuthorizationStatus.authorizedAlways
    
    // MARK: - SharedInstance
    class var shared: LocationServices{
        struct Singleton{
            static let instance = LocationServices()
        }
        return Singleton.instance
    }
    
    func getCurrentLocation() -> CLLocation?{
        self.locManager.delegate = self
        self.locManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locManager.requestWhenInUseAuthorization()
        if (self.authStatus != CLAuthorizationStatus.denied){
            self.currentLocation = locManager.location
            if currentLocation == nil{
                return CLLocation(latitude: 28.7041, longitude: 77.1025)
            }else{
                return self.currentLocation
            }
        }else{
            showLocationPermission()
        }
        return CLLocation(latitude: 28.7041, longitude: 77.1025)
    }
    
    func getAdress(completion: @escaping (_ address: CLPlacemark?, _ error: Error?) -> ()) {
        self.locManager.delegate = self
        self.locManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locManager.requestWhenInUseAuthorization()
        if (self.authStatus != CLAuthorizationStatus.denied){
            self.currentLocation = locManager.location
            if currentLocation == nil{
                return
            }
            
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(self.currentLocation) { placemarks, error in
                if let e = error {
                    completion(nil, e)
                } else {
                    let placeArray = placemarks as? [CLPlacemark]
                    var placeMark: CLPlacemark!
                    placeMark = placeArray?[0]
//                    guard let address = placeMark.addressDictionary as? JSONDictionary else {
//                        return
//                    }
                    completion(placeMark, nil)
                }
            }
        }else{
            showLocationPermission()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authStatus = CLLocationManager.authorizationStatus()
        inUse = CLAuthorizationStatus.authorizedWhenInUse
        always = CLAuthorizationStatus.authorizedAlways
    }
    
    func showLocationPermission(){
        let alert = UIAlertController(title: "Enable Location Service", message: "HorseBnB needs to access your location", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Setting", style: UIAlertAction.Style.destructive, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                // If general location settings are enabled then open location settings for the app
                if let myUrl = URL(string: "\(url)") {
                    UIApplication.shared.open(myUrl, options: [:], completionHandler: nil)
                }
                //                        UIApplication.shared.openURL(url)
            }
        }) )
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { _ in
            self.cancelled = true
        }))
        let nav = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
        if !self.cancelled{
            nav.topViewController?.present(alert, animated: true, completion: nil)
        }
    }
}
