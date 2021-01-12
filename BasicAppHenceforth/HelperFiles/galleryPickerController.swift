//
//  galleryPickerController.swift
//  BasicAppHenceforth
//
//  Created by NegiMac on 12/01/21.
//

import UIKit
import YPImagePicker

enum MediaType {
    case Gallery
    case Camera
    case PhotoCamera
    case PhotoGallery
    case VideoCamera
    case VideoGallery
    
    case Photo
    case Video
    case All
}

class mediaPickerController: NSObject{
    
    class var shared: mediaPickerController {
        struct Static {
            static let instance = mediaPickerController()
        }
        return Static.instance
    }
    
    func openingMediaController(_ vc : UIViewController, media: MediaType, max: Int, images: @escaping ([UIImage])->() , videos: @escaping ([URL])->()){
        var config = YPImagePickerConfiguration()
        if media == .PhotoCamera || media == .PhotoGallery || media == .Photo{
            config.library.mediaType = .photo
            if media == .PhotoCamera{
                config.startOnScreen = .photo
                config.screens = [.photo]
            }else if media == .PhotoGallery{
                config.startOnScreen = .library
                config.screens = [.library]
            }else{
                config.startOnScreen = .photo
                config.screens = [.photo, .library]
            }
            
        }else if media == .VideoCamera || media == .VideoGallery || media == .Video{
            config.library.mediaType = .video
            if media == .VideoCamera{
                config.startOnScreen = .video
                config.screens = [.video]
            }else if media == .VideoGallery{
                config.startOnScreen = .library
                config.screens = [.library]
            }else{
                config.startOnScreen = .video
                config.screens = [.video, .library]
            }
        }else if media == .Camera || media == .Gallery || media == .All{
            config.library.mediaType = .photoAndVideo
            if media == .Camera{
                config.startOnScreen = .photo
                config.screens = [.photo, .video]
            }else if media == .Gallery{
                config.startOnScreen = .library
                config.screens = [.library]
            }else{
                config.startOnScreen = .library
                config.screens = [.library, .photo, .video]
            }
        }
        
        config.shouldSaveNewPicturesToAlbum = false

        config.showsCrop = .rectangle(ratio: (16/9))
        config.wordings.libraryTitle = "Gallery"
        config.hidesStatusBar = false
        config.hidesBottomBar = false
        
        config.maxCameraZoomFactor = 2.0

        config.library.maxNumberOfItems = max
        config.showsCrop = .none
        config.showsPhotoFilters = false
        config.gallery.hidesRemoveButton = false

//        config.library.preselectedItems = selectedItems

        let picker = YPImagePicker(configuration: config)

        picker.didFinishPicking { [unowned picker] items, cancelled in

            if cancelled {
                print("Picker was canceled")
                picker.dismiss(animated: true, completion: nil)
                return
            }
            
            var photos : [UIImage] = []
            var videosURL : [URL] = []

            for item in items{
                switch item {
                case .photo(let photo):
                    photos.append(photo.image)
                case .video(let video):
                    videosURL.append(video.url)
                default:
                    print("error")
                }
            }
            
            images(photos)
            videos(videosURL)
            picker.dismiss(animated: true, completion: nil)
        }
        vc.present(picker, animated: true, completion: nil)
    }
}
