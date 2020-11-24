//
//  button.swift
//  NewApp
//
//  Created by Think Recycling Pvt Ltd on 26/08/19.
//  Copyright © 2019 Think Recycling Pvt Ltd. All rights reserved.
//

import UIKit

extension UIView{
    //extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-12.0, 12.0, -8.0, 8.0, -4.0, 4.0, -2.0, 2.0 ]
        layer.add(animation, forKey: "shake")
    }
    func drawLineFromPointView(start : CGPoint, toPoint end:CGPoint, ofColor lineColor: UIColor) {
        //design the path
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)

        //design path in layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = 1.0
        shapeLayer.lineDashPattern = [6,3]
        self.layer.addSublayer(shapeLayer)
    }
    
    func addDashedBorder() {
      let shapeLayer:CAShapeLayer = CAShapeLayer()
      let frameSize = self.frame.size
      let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
      shapeLayer.bounds = shapeRect
      shapeLayer.position = CGPoint(x: frameSize.width/2, y: (frameSize.height/2))
      shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.darkGray.cgColor
      shapeLayer.lineWidth = 1
      shapeLayer.lineJoin = CAShapeLayerLineJoin.round
      shapeLayer.lineDashPattern = [6,3]
      shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 26).cgPath
      self.layer.addSublayer(shapeLayer)
    }
    
    func addDashedBorderAlarm() {
      let shapeLayer:CAShapeLayer = CAShapeLayer()
      let frameSize = self.frame.size
      let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
      shapeLayer.bounds = shapeRect
      shapeLayer.position = CGPoint(x: frameSize.width/2, y: (frameSize.height/2))
      shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.systemGray.cgColor
      shapeLayer.lineWidth = 1
      shapeLayer.lineJoin = CAShapeLayerLineJoin.round
      shapeLayer.lineDashPattern = [6,3]
      shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 12).cgPath
      self.layer.addSublayer(shapeLayer)
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
      let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
      let mask = CAShapeLayer()
      mask.path = path.cgPath
      self.layer.mask = mask
    }
}
