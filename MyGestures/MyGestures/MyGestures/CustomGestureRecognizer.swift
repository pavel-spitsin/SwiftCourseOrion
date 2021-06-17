//
//  CustomGestureRecognizer.swift
//  MyGestures
//
//  Created by Pavel Spitcyn on 09.06.2021.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

enum SymbolPhase {
    case notStarted
    case initialPoint
    case rightDownStroke
    case leftDownStroke
}

class CustomGestureRecognizer: UIGestureRecognizer {

    var strokePhase : SymbolPhase = .notStarted
    var initialTouchPoint : CGPoint = CGPoint.zero
    var trackedTouch : UITouch? = nil
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        if touches.count != 1 {
            self.state = .failed
        }
        // Capture the first touch and store some information about it.
        if self.trackedTouch == nil {
            self.trackedTouch = touches.first
            self.strokePhase = .initialPoint
            self.initialTouchPoint = (self.trackedTouch?.location(in: self.view))!
        } else {
            // Ignore all but the first touch.
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
        // There should be only the first touch.
        guard newTouch == self.trackedTouch else {
            self.state = .failed
            return
        }
        let newPoint = (newTouch?.location(in: self.view))!
        let previousPoint = (newTouch?.previousLocation(in: self.view))!

        if self.strokePhase == .initialPoint {
            // Make sure the initial movement is down and to the right.
            if newPoint.x >= initialTouchPoint.x && newPoint.y >= initialTouchPoint.y {
                self.strokePhase = .rightDownStroke
            } else {
                self.state = .failed
            }
        } else if self.strokePhase == .rightDownStroke {
            // Make sure the initial movement is down and to the left.
            if newPoint.y >= previousPoint.y {
                if newPoint.x <= previousPoint.x {
                    self.strokePhase = .leftDownStroke
                }
            }  else {
                self.state = .failed
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        let newTouch = touches.first
        // There should be only the first touch.
        guard newTouch == self.trackedTouch else {
            self.state = .failed
            return
        }
        let newPoint = (newTouch?.location(in: self.view))!
        // If the stroke was down up and the final point is
        // below the initial point, the gesture succeeds.
        if self.state == .possible &&
            self.strokePhase == .leftDownStroke &&
            newPoint.y > initialTouchPoint.y {
            self.state = .recognized
        } else {
            self.state = .failed
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
       super.touchesCancelled(touches, with: event)
       self.state = .cancelled
       reset()
   }

   override func reset() {
       super.reset()
       self.initialTouchPoint = CGPoint.zero
       self.strokePhase = .notStarted
       self.trackedTouch = nil
   }
    
    
}
