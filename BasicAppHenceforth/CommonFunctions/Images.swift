//
//  d.swift
//  NewApp
//
//  Created by Think Recycling Pvt Ltd on 26/08/19.
//  Copyright © 2019 Think Recycling Pvt Ltd. All rights reserved.
//

import UIKit

enum Asset : String {
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
//    case catsel = "ic_fill_oval"
//    case catUnsel = "ic_oval_unfill"
    
    func image () -> UIImage{
        return UIImage(named: self.rawValue)!
    }
}

