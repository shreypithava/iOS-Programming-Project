//
//  RegisterGesture.swift
//  Project
//
//  Created by Shrey Pithava on 5/12/19.
//  Copyright © 2019 Shrey Pithava. All rights reserved.
//

import UIKit

class RegisterGesture: UIGestureRecognizer {
    // Recognises the letter Z
    enum DirectionPhases {
        case notStarted
        case initialPoint
        case goingRight
        case goingDownLeft
        case goingRightAgain
    }
    
    var strokePhase : DirectionPhases = .notStarted
    var initialTouchPoint: CGPoint = CGPoint.zero
    var trackedTouch: UITouch? = nil
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        // Check if this is only 1 finger touch, if not, fail out
        if touches.count != 1 {
            self.state = .failed
        }
        
        // if only finger, let's track the initial touch
        if self.trackedTouch == nil {
            self.trackedTouch = touches.first
            self.strokePhase = .initialPoint
            self.initialTouchPoint = (self.trackedTouch?.location(in: self.view))!
        } else {
            for touch in touches {
                if touch != self.trackedTouch {
                    self.ignore(touch, for: event)
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        let newTouch = touches.first
        // There should be only the first touch
        guard newTouch == self.trackedTouch else {
            self.state = .failed
            return
        }
        
        // Grab information about the new touches that have occurred
        let newPoint = (newTouch?.location(in: self.view))!
        let previousPoint = (newTouch?.previousLocation(in: self.view))!
        print ("newPoint.x is \(newPoint.x)")
        print ("newPoint.y is \(newPoint.y)")
        print ("initialTouchPoint.x is \(initialTouchPoint.x)")
        print ("initialTouchPoint.y is \(initialTouchPoint.y)")
        
        if self.strokePhase == .initialPoint {
            // Need to verify that we are moving down and to the right
            if newPoint.x >= initialTouchPoint.x {
                self.strokePhase = .goingRight
            } else {
                print("Failed At initial Point")
                self.state = .failed
            }
            
        } else if self.strokePhase == .goingRight {
            // We are currently going right
            if newPoint.x <= previousPoint.x {
                // Let's check if we starting going downLeft
                if newPoint.y > previousPoint.y {
                    self.strokePhase = .goingDownLeft
                } else {
                    print("Failed at going right")
                    self.state = .failed
                }
            }
            
        } else if self.strokePhase == .goingDownLeft {
            // We are currently going up and to the right
            if newPoint.x >= previousPoint.x {
                self.strokePhase = .goingRightAgain
            } else if newPoint.y < previousPoint.y {
                self.state = .failed
            }
        } else if self.strokePhase == .goingRightAgain {
            if newPoint.x < previousPoint.x {
                self.state = .failed
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        let newTouch = touches.first
        let newPoint = (newTouch?.location(in: self.view))!
        guard newTouch == self.trackedTouch else {
            self.state = .failed
            return
        }
        
        if self.state == .possible && self.strokePhase == .goingRightAgain && newPoint.x > initialTouchPoint.x && newPoint.y > initialTouchPoint.y {
            self.state = .recognized
        } else {
            self.state = .failed
        }
    }
    
    
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)
        self.initialTouchPoint = CGPoint.zero
        self.strokePhase = .notStarted
        self.trackedTouch = nil
        self.state = .cancelled
    }
    
    override func reset() {
        super.reset()
        self.initialTouchPoint = CGPoint.zero
        self.strokePhase = .notStarted
        self.trackedTouch = nil
    }
}
