//
//  d.swift
//  NewApp
//
//  Created by Think Recycling Pvt Ltd on 26/08/19.
//  Copyright © 2019 Think Recycling Pvt Ltd. All rights reserved.
//

import UIKit

#if os(iOS) || os(tvOS) || os(watchOS)
    import UIKit.UIImage
    typealias Image = UIImage
#elseif os(OSX)
    import AppKit.NSImage
    typealias Image = NSImage
#endif

enum Asset : String {
    case ic_splash1 = "one"
    case ic_splash2 = "two"
    case ic_splash3 = "three"
    case ic_hideeye_review = "visibility_off"
    case ic_eye_review = "visibility"
    case ic_checked = "check_box_fill"
    case ic_notChecked = "check_box"
    case icNotifi_on = "off_btn"
    case icNotifi_off = "on_btn"
    case ic_tick_2 = "ic_circle_fill"
    case ic_Non_tick = "ic_circle_unfill"
    case heart_fill = "favorite_fill"
    case heart_unfill = "favorite_border"
    case ic_click_unselected = "check_circle_outline-2"
    case ic_click_selected = "check_circle_green"
    case ic_cancel_unselected = "cancel_outline"
    case ic_cancel_selected = "cancel-1"
    case ic_checked_Green = "check_box-1"
    case ic_back = "ic_back"
//    case catsel = "ic_fill_oval"
//    case catUnsel = "ic_oval_unfill"
    
    case profile_select = "profile_select"
    case email = "email"
    case ic_phone_number = "phone_number"
    case user = "user"
    case ic_edit_white = "ic_edit_white"
    case verified = "verified"
    case ic_send = "send"
    case ic_downArrow = "ic_downArrow"
    
    case ic_back_white = "ic_back_white"
    case ic_AttachFile = "attach_file"
    case ic_ContentCopy = "content_copy"
    case ic_Delete = "delete"
    case ic_Forward = "forward"
    case ic_Play_Circle_Outline = "play_circle_outline"
    case ic_Reply = "reply"
    case ic_Share = "share"
    
    case ic_mic_color = "mic_color"
    case ic_mic_white = "mic_white"
    case ic_pause = "pause"
    case ic_play_audio = "play_audio"

    func image () -> UIImage{
        return UIImage(named: self.rawValue)!
    }
}


extension Image {
    convenience init!(asset: Asset) {
        self.init(named: asset.rawValue)
    }
}
