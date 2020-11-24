//
//  Extension+UITextField.swift
//  NewApp
//
//  Created by Think Recycling Pvt Ltd on 27/08/19.
//  Copyright © 2019 Think Recycling Pvt Ltd. All rights reserved.
//

import UIKit

extension UITextField {
    // open left view with image
    func openLeftViewWithImage(_ imageNamed: UIImage, height: CGFloat, tintColor : UIColor, imageTintColor: UIColor){
//        let image = imageNamed.imageWithInsets(insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        self.leftViewMode = .always
        let leftView = UIImageView(frame: CGRect(x: CGFloat(8), y: CGFloat(0), width: CGFloat(height), height: CGFloat(height)))
        
//        leftView.image = image
        leftView.image = imageNamed.imageWithInsets(insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
//        leftView.frame = CGRect(x: CGFloat(8), y: CGFloat(0), width: CGFloat(height), height: CGFloat(height))
        leftView.tintColor = tintColor
        leftView.contentMode = .center
        self.leftView = leftView
        
        
        
//        let image = imageNamed.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
//        self.leftViewMode = .always
//        let leftView = UIImageView(frame: CGRect(x: 8, y: 0, width: height, height: height))
//        leftView.image = image
//        leftView.tintColor = tintColor
//        leftView.contentMode = .center
//        self.leftView = leftView
    }
    
    func openLeftViewWithImage(_ imageNamed: UIImage, height: CGFloat, tintColor : UIColor){
        self.leftViewMode = .always
        let leftView = UIImageView(frame: CGRect(x: 8, y: 0, width: height, height: height))
        leftView.image = imageNamed
        leftView.tintColor = tintColor
        leftView.contentMode = .center
        self.leftView = leftView
    }
    
    func openLeftViewWithImage(_ imageNamed: UIImage, height: CGFloat){
        self.leftViewMode = .always
        let leftView = UIImageView()
        leftView.alpha = 0.5
//        let leftView = UIImageView(frame: CGRect(x: 8, y: 0, width: height, height: height))
        leftView.image = imageNamed.imageWithInsets(insets: UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 8))
        leftView.frame = CGRect(x: CGFloat(8), y: CGFloat(0), width: CGFloat(height), height: CGFloat(height))
        leftView.contentMode = .center
        self.leftView = leftView
    }
    
    func openView(_ isLeft: Bool, img: UIImageView){
        if isLeft{
            self.leftViewMode = .always
            self.leftView = img
        }else{
            self.rightViewMode = .always
            self.rightView = img
        }
    }
    
    func openRightViewWithImage(_ imageNamed: UIImage, height: CGFloat){
        self.rightViewMode = .always
        let leftView = UIImageView()
//        let leftView = UIImageView(frame: CGRect(x: 8, y: 0, width: height, height: height))
        leftView.image = imageNamed.imageWithInsets(insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 16))
        leftView.frame = CGRect(x: CGFloat(8), y: CGFloat(0), width: CGFloat(height), height: CGFloat(height))
        leftView.contentMode = .center
        self.rightView = leftView
        }
    
    func customeFont (fontName name : String, maximumFontValue size: CGFloat){
        self.adjustsFontForContentSizeCategory = true
        self.font = CommonFunctions.getFont(fontName: name, maximumFontValue: size)
    }
    
    // open left view with image with square space
    func openLeftViewWithSquareImage(_ image: UIImage){
        self.leftViewMode = .always
        let leftView = UIImageView(frame: CGRect(x: 8, y: 0, width: self.frame.height, height: self.frame.height))
        leftView.image = image
        leftView.contentMode = .center
        self.leftView = leftView
    }
    
   
    
    // set text field with placeholder text and color
    func setPlaceHolderColor(_ setColor: UIColor, placeholderText : String){
        self.tintColor = Colors.RedColor.color()
        self.attributedPlaceholder = NSAttributedString(string: placeholderText,
                                                        attributes: [NSAttributedString.Key.foregroundColor: setColor])
    }
    
    // set text field with placeholder text, color & font
    func setPlaceHolderColor(_ setColor: UIColor, placeholderText : String, placeholderFont : UIFont){
        self.tintColor = Colors.tfTextColor.color()
        self.attributedPlaceholder = NSAttributedString(string: placeholderText,
                                                        attributes: [NSAttributedString.Key.foregroundColor: setColor, NSAttributedString.Key.font: placeholderFont])
    }
    
    func setIcon(_ image: UIImage) {
       let iconView = UIImageView(frame:
                      CGRect(x: self.frame.midX - 68, y: 3, width: 16, height: 14))
       iconView.image = image
       let iconContainerView: UIView = UIView(frame:
                      CGRect(x: 0, y: 0, width: 16, height: 20))
       iconContainerView.addSubview(iconView)
        
        print(self.frame.midX)
       leftView = iconContainerView
       leftViewMode = .always
    }
}

