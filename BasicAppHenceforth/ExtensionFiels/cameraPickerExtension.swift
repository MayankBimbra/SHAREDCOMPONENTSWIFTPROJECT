//
//  CameraPicker.swift
//  viral
//
//  Created by Henceforth on 04/04/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import UIKit
import Fusuma
import Photos
import AVFoundation

enum ImagePickerMode  : String{
    case Camera = "Camera"
    case Gallery = "Photo Library"
    case All = "Camera and Photo Library"
    func title() -> String{
        switch self {
        case .Camera:
            return "Camera"
        default:
            return "Photo Library"
        }
    }
}

class CameraGalleryPicker: NSObject, FusumaDelegate{
    
    typealias onPicked = (UIImage) -> ()
    typealias onMultiplePicked = ([UIImage]) -> ()
    typealias onCanceled = () -> ()
    
    var pickedListner : onPicked?
    var pickedMultipleListner : onMultiplePicked?
    var canceledListner : onCanceled?
    
    class var sharedInstance: CameraGalleryPicker {
        struct Static {
            static let instance = CameraGalleryPicker()
        }
        return Static.instance
    }
    
    func pickerImage( mode : ImagePickerMode , presentInVc : UIViewController , pickedListner : @escaping onPicked , pickedMultipleListner : @escaping onMultiplePicked, canceledListner : @escaping onCanceled, maxLimit: Int){
        
        self.pickedListner = pickedListner
        self.pickedMultipleListner = pickedMultipleListner
        self.canceledListner = canceledListner

        if mode == .Camera{
            if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == .denied{
                let alert = UIAlertController(title: "Horsebnb want to access your Camera", message: "Please give camera permission in setting page", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Setting", style: UIAlertAction.Style.destructive, handler: { _ in
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }
                    
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                            print("Settings opened: \(success)") // Prints true
                        })
                    }
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { _ in  }))
                presentInVc.present(alert, animated: true, completion: nil)
            }
        }else{
            if PHPhotoLibrary.authorizationStatus() == .denied{
                let alert = UIAlertController(title: "Horsebnb want to access your Gallery", message: "Please give photos permission in setting page", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Setting", style: UIAlertAction.Style.destructive, handler: { _ in
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }
                    
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                            print("Settings opened: \(success)") // Prints true
                        })
                    }
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { _ in  }))
                presentInVc.present(alert, animated: true, completion: nil)
            }
//        }else{
            
        }
        let fusuma = FusumaViewController()
        fusuma.delegate = self
        if mode == .Camera{
            fusuma.availableModes = [FusumaMode.camera]
        }else if mode == .Gallery{
            fusuma.availableModes = [FusumaMode.library]
        }else{
            fusuma.availableModes = [FusumaMode.camera, FusumaMode.library]
        }
//        fusumaCropImage = false
        fusuma.cropHeightRatio = 1 // Height-to-width ratio. The default value is 1, which means a squared-size photo.
        fusuma.allowMultipleSelection = maxLimit == 1 ? false : true // You can select multiple photos from the camera roll. The default value is false.
        fusuma.photoSelectionLimit = maxLimit
        DispatchQueue.main.async {
            presentInVc.present(fusuma, animated: true, completion: nil)
        }
    }
    
    func fusumaMultipleImageSelected(_ images: [UIImage], source: FusumaMode, metaData: [ImageMetadata]) {
        print("Multiple Image selected with metadata")
        var kImages : [UIImage] = []
        for img in images {
            kImages.append(fixOrientation(img))
        }
        pickedMultipleListner!(kImages)
    }
    
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode, metaData: ImageMetadata) {
        print("Single Image selected with metadata")
        pickedMultipleListner!([fixOrientation(image)])
    }
    
    func fusumaDismissedWithImage(_ image: UIImage, source: FusumaMode) {
//        if source == FusumaMode.camera{
//            pickedMultipleListner!([image])
//        }
    }
    
    func fusumaClosed() {
        print("fusumaClosed")
        if let listener = canceledListner{
            listener()
        }
    }
    
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {
        print("fusumaImageSelected",image,source)
        pickedMultipleListner!([fixOrientation(image)])
    }
    
    func fusumaVideoCompleted(withFileURL fileURL: URL) {
        print("fusumaVideoCompleted",fileURL)
    }
    
    func fusumaCameraRollUnauthorized() {
        print("fusumaCameraRollUnauthorized")
    }
    
    func fusumaMultipleImageSelected(_ images: [UIImage], source: FusumaMode) {
        var kImages : [UIImage] = []
        for img in images {
            kImages.append(fixOrientation(img))
        }
        print("fusumaMultipleImageSelected", kImages, source)
    }

    func fixOrientation(_ img: UIImage) -> UIImage {
        if (img.imageOrientation == .up) {
            return img
        }
        
        UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale)
        let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
        img.draw(in: rect)
        
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return normalizedImage
    }
    
    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true, completion: nil)
//        if let listener = canceledListner{
//            listener()
//        }
//    }
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//
//            pickedListner!(pickedImage)
//
//        }
//        //
//        picker.dismiss(animated: true, completion: nil)
//
//    }
}

