//
//  Extension+UITextField.swift
//  NewApp
//
//  Created by Think Recycling Pvt Ltd on 27/08/19.
//  Copyright © 2019 Think Recycling Pvt Ltd. All rights reserved.
//

import UIKit

extension UITextField {
    func openView(_ isLeft: Bool, img: UIImageView){
        if isLeft{
            self.leftViewMode = .always
            self.leftView = img
        }else{
            self.rightViewMode = .always
            self.rightView = img
        }
    }
    
    func customeFont (fontName name : String, maximumFontValue size: CGFloat){
        self.adjustsFontForContentSizeCategory = true
        self.font = CommonFunctions.getFont(fontName: name, maximumFontValue: size)
    }
    
    // set text field with placeholder text and color
    func setPlaceHolderColor(_ setColor: UIColor, placeholderText : String){
        self.tintColor = setColor
        self.attributedPlaceholder = NSAttributedString(string: placeholderText,
                                                        attributes: [NSAttributedString.Key.foregroundColor: setColor])
    }
    
    // set text field with placeholder text, color & font
    func setPlaceHolderColor(_ setColor: UIColor, placeholderText : String, placeholderFont : UIFont){
        self.tintColor = setColor
        self.attributedPlaceholder = NSAttributedString(string: placeholderText,
                                                        attributes: [NSAttributedString.Key.foregroundColor: setColor, NSAttributedString.Key.font: placeholderFont])
    }
    
    func disableAutoFill() {
        if #available(iOS 12, *) {
            textContentType = .oneTimeCode
        } else {
            textContentType = .init(rawValue: "")
        }
    }
}

