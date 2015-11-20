//
//  CradleLoading.swift
//  NewtonsCradleLoading
//
//  Created by ryota-ko on 2015/11/20.
//  Copyright © 2015年 ryota-ko. All rights reserved.
//

import UIKit

class LoadingView: UIView, UICollisionBehaviorDelegate {
    
    typealias BearingsArray = Array<BallView>
    private var ballBearings: Array<BallView> = []
    private var userDragBehavior : UIPushBehavior?
    lazy private var animator: UIDynamicAnimator = {
        return UIDynamicAnimator(referenceView: self)
        }()
    private var direction: Bool = false
    
    func setupBall(){
        createBall()
        applyDynamicBehaviors()
    }
    
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
    
    private func applyDynamicBehaviors() {
        let behavior = UIDynamicBehavior()
        for ballBearing in ballBearings {
            let attachmentBehavior: UIDynamicBehavior = createAttachmentBehaviorForBallBearing(ballBearing)
            behavior.addChildBehavior(attachmentBehavior)
        }
        
        behavior.addChildBehavior(createGravityBehaviorForObjects(ballBearings))
        behavior.addChildBehavior(createCollisionBehaviorForObjects(ballBearings))
        
        let itemBehavior = UIDynamicItemBehavior(items: ballBearings)
        itemBehavior.elasticity = 1.4
        itemBehavior.allowsRotation = false
        itemBehavior.resistance = 4.0
        behavior.addChildBehavior(itemBehavior)
        
        animator = UIDynamicAnimator(referenceView: self)
        animator.delegate = self
        animator.addBehavior(behavior)
    }
    
    // MARK - UIDynamicBehavior
    
    func createCollisionBehaviorForObjects(objetcs: BearingsArray) -> UIDynamicBehavior {
        let collision = UICollisionBehavior(items: objetcs)
        return collision
    }
    
    func createGravityBehaviorForObjects(objects: BearingsArray) -> UIDynamicBehavior {
        let gravity = UIGravityBehavior(items: [objects[0],objects[4]])
         gravity.magnitude = 5
        let first = UIGravityBehavior(items: [objects[1],objects[2],objects[3]])
        first.magnitude = 5
       
        return gravity
    }
    
    func createAttachmentBehaviorForBallBearing(bearing: BallView) -> UIDynamicBehavior {
        var anchor: CGPoint = bearing.center
        anchor.y -= CGRectGetHeight(bounds) / CGFloat(6.0);
        
        let blueBox = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        blueBox.backgroundColor = UIColor.greenColor()
        blueBox.center = anchor
        //addSubview(blueBox)
        
        let behavior = UIAttachmentBehavior(item: bearing, attachedToAnchor: anchor)
        return behavior
    }
    
    func collisionBehavior(behavior: UICollisionBehavior, endedContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem) {
        print("\(item1) colided with \(item2) ")
    }
    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, atPoint p: CGPoint){
        print("\(item) colided at \(p) ")
    }
}
extension LoadingView : UIDynamicAnimatorDelegate {
    
    func dynamicAnimatorDidPause(animator: UIDynamicAnimator) {
        print("pause")
        createUserPush()
    }
    func dynamicAnimatorWillResume(animator: UIDynamicAnimator) {
        print("resume")
    }
}
