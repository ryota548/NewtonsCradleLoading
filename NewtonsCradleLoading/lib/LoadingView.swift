//
//  CradleLoading.swift
//  NewtonsCradleLoading
//
//  Created by ryota-ko on 2015/11/20.
//  Copyright © 2015年 ryota-ko. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    private var ballsArray: Array<BallView> = []
    
    func setupBall(){
        createBall()
    }
    
    private func createBall(){
        let numberOfBalls: Int = 5
        let ballGap: CGFloat = (3.0 * CGFloat(numberOfBalls - 1))
        print(self.frame)
        let ballSize = CGRectGetWidth(self.bounds) / ballGap
        
        for ballNo in 1...numberOfBalls {
            let ballFrame = CGRect(x: 0, y: 0, width: ballSize - 1, height: ballSize - 1)
            let ball = BallView(frame: ballFrame)
            
            let gap = CGFloat(ballNo) * ballSize
            let x = CGRectGetWidth(self.bounds) / 3.0 + gap
            let y = CGRectGetHeight(self.bounds) / 2.0
            
            ball.center = CGPoint(x: x, y: y)
            ballsArray.append(ball)
            self.addSubview(ball)
        }
        
    }
}
