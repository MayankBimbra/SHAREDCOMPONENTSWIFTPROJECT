//
//  UITextFieldWxtension.swift
//  Lowicks
//
//  Created by Think Recycling Pvt Ltd on 02/09/19.
//  Copyright © 2019 MAC. All rights reserved.
//

import UIKit

class UITextFieldWxtension: UITextField {
        
        let padding = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 4)
        
        override open func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
        
        override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
        
        override open func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
}

class paddingLeftSide: UITextField{
    let padding = UIEdgeInsets(top: 0, left: 44, bottom: 0, right: 12)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

class UITextViewPadding : UITextView {
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    textContainerInset = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 20)
  }
}
