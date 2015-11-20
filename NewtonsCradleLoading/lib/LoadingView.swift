//
//  CradleLoading.swift
//  NewtonsCradleLoading
//
//  Created by ryota-ko on 2015/11/20.
//  Copyright © 2015年 ryota-ko. All rights reserved.
//

import UIKit

protocol Method{
    func setupBall() -> Void
    func stop() -> Void
    func ballColor() -> Void
    func ballSpead() -> Void
    func applyBlur() -> Void
}

public class LoadingView: UIView, Method, UICollisionBehaviorDelegate {
    
    typealias BearingsArray = Array<BallView>
    
    private var ballBearings: Array<BallView> = []
    private var effectView : UIVisualEffectView!
    private var userDragBehavior : UIPushBehavior?
    lazy private var animator: UIDynamicAnimator = {
        return UIDynamicAnimator(referenceView: self)
        }()
    private var direction: Bool = false
    
    public func setupBall(){
        createBall()
        applyDynamicBehaviors()
        createUserPush()
    }
    public func stop(){
        deleteView()
    }
    public func ballColor(){
        //球の色の変える
    }
    public func ballSpead() {
        //球の速度を変える
    }
    public func applyBlur() {
        //ブラーの適用
        effectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.ExtraLight))
        addSubview(effectView)
    }
    
    //球の生成
    private func createBall(){
        let numberOfBalls: Int = 5
        let ballGap: CGFloat = (3.0 * CGFloat(numberOfBalls - 1))
        let ballSize = CGRectGetWidth(self.bounds) / ballGap
        
        for ballNo in 1...numberOfBalls {
            let ballFrame = CGRect(x: 0, y: 0, width: ballSize - 1, height: ballSize - 1)
            let ball = BallView(frame: ballFrame)
            
            let gap = CGFloat(ballNo) * ballSize
            let x = CGRectGetWidth(self.bounds) / 3.0 + gap
            let y = CGRectGetHeight(self.bounds) / 2.0
            
            ball.center = CGPoint(x: x, y: y)
            ballBearings.append(ball)
            self.addSubview(ball)
        }
    }
    
    //アニメーションの設定
    private func applyDynamicBehaviors() {
        let behavior = UIDynamicBehavior()
        for ballBearing in ballBearings {
            let attachmentBehavior: UIDynamicBehavior = createAttachmentBehaviorForBallBearing(ballBearing)
            behavior.addChildBehavior(attachmentBehavior)
        }
        
        behavior.addChildBehavior(createGravityBehaviorForObjects(ballBearings))
        behavior.addChildBehavior(createCollisionBehaviorForObjects(ballBearings))
        
        let itemBehavior = UIDynamicItemBehavior(items: ballBearings)
        itemBehavior.elasticity = 1.5
        itemBehavior.allowsRotation = false
        itemBehavior.resistance = 5.0
        behavior.addChildBehavior(itemBehavior)
        
        animator = UIDynamicAnimator(referenceView: self)
        animator.addBehavior(behavior)
    }
    
    // MARK - UIDynamicBehavior
    
    private func createCollisionBehaviorForObjects(objetcs: BearingsArray) -> UIDynamicBehavior {
        let collision = UICollisionBehavior(items: objetcs)
        return collision
    }
    
    private func createGravityBehaviorForObjects(objects: BearingsArray) -> UIDynamicBehavior {
        let gravity = UIGravityBehavior(items: objects)
        gravity.magnitude = 8
        return gravity
    }
    
    private func createAttachmentBehaviorForBallBearing(bearing: BallView) -> UIDynamicBehavior {
        var anchor: CGPoint = bearing.center
        anchor.y -= CGRectGetHeight(bounds) / CGFloat(6.0);
        let node = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        node.center = anchor
        let behavior = UIAttachmentBehavior(item: bearing, attachedToAnchor: anchor)
        return behavior
    }
    
    //アニメーションの開始
    private func createUserPush() {
        direction = !direction
        if  (direction) {
            userDragBehavior = UIPushBehavior(items: [ballBearings.first!],
                mode: UIPushBehaviorMode.Instantaneous)
        } else {
            userDragBehavior = UIPushBehavior(items: [ballBearings.last!],
                mode: UIPushBehaviorMode.Instantaneous)
        }
        userDragBehavior!.pushDirection = CGVectorMake(-0.5, 0)
        animator.addBehavior(userDragBehavior!)
    }

    //Viewを削除
    private func deleteView(){
        self.hidden = true
    }
}