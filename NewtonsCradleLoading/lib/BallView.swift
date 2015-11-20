//
//  BallView.swift
//  NewtonsCradleLoading
//
//  Created by ryota-ko on 2015/11/20.
//  Copyright © 2015年 ryota-ko. All rights reserved.
//

import UIKit
import QuartzCore

class BallView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.blueColor()
        layer.cornerRadius = min(CGRectGetHeight(frame), CGRectGetWidth(frame)) / 2.0
        layer.borderColor = UIColor.grayColor().CGColor
        layer.borderWidth = 1.0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
