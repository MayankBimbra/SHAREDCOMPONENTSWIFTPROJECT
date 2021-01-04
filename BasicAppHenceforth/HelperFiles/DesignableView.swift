//
//  DesignableView.swift
//  LiqrooCustomer
//
//  Created by Admin on 21/08/19.
//  Copyright © 2019 Gaurav Kumar. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class DesignableView: UIView {
    
    @IBInspectable var BoorderWidth : CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = BoorderWidth
        }
    }
    
    @IBInspectable var ShaadowRadius : CGFloat = 0.0 {
        didSet {
            self.layer.shadowRadius = ShaadowRadius
        }
    }
    
    @IBInspectable var CoornerRadius : CGFloat = 0.0 {
        didSet {
            
            self.layer.cornerRadius = CoornerRadius
        }
    }
    
    @IBInspectable var MaaskToBound : Bool = true {
        didSet {
            self.layer.masksToBounds = MaaskToBound
        }
    }
    
    @IBInspectable var ShaadowOffset : CGSize = CGSize(width: 0.0, height: 0.0) {
        didSet {
            self.layer.shadowOffset = ShaadowOffset
        }
    }
    
    @IBInspectable var ShaadowColor : UIColor = UIColor.clear {
        didSet {
            self.layer.shadowColor = ShaadowColor.cgColor
        }
    }
    
    @IBInspectable var ShaadowOpacity : Float = 0.0 {
        didSet {
            self.layer.shadowOpacity = ShaadowOpacity
        }
    }
    
    @IBInspectable var BoorderColor : UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = BoorderColor.cgColor
        }
    }
}
