//
//  CustomProgressView.swift
//  Horsebnb
//
//  Created by Think Recycling Pvt Ltd on 21/09/20.
//  Copyright © 2020 Think Recycling Pvt Ltd. All rights reserved.
//

import Foundation

class customProgresssView: UIProgressView {
  /*
  // Only override draw() if you perform custom drawing.
  // An empty implementation adversely affects performance during animation.
  override func draw(_ rect: CGRect) {
    // Drawing code
  }
  */
  override func layoutSubviews() {
    super.layoutSubviews()
    let maskLayerPath = UIBezierPath(roundedRect: bounds, cornerRadius: 4.0)
    let maskLayer = CAShapeLayer()
    maskLayer.frame = self.bounds
    maskLayer.path = maskLayerPath.cgPath
    layer.mask = maskLayer
  }
}
