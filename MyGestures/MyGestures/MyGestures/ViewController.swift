//
//  ViewController.swift
//  MyGestures
//
//  Created by Pavel Spitcyn on 08.06.2021.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    var testScale = CGFloat(1.0)
    var testRotation = CGFloat(1.0)
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var tap: UITapGestureRecognizer!
    @IBOutlet var twoFingersDoubleTap: UITapGestureRecognizer!
    @IBOutlet var pinch: UIPinchGestureRecognizer!
    @IBOutlet var panGesture: UIPanGestureRecognizer!
    @IBOutlet var rotationGesture: UIRotationGestureRecognizer!
    @IBOutlet var swipeGesture: UISwipeGestureRecognizer!
    @IBOutlet var screenEdgePanGesture: UIScreenEdgePanGestureRecognizer!
    @IBOutlet var longPressGesture: UILongPressGestureRecognizer!
    @IBOutlet var customGesture: CustomGestureRecognizer!


    //MARK: - IBActions
    
    @IBAction func tapGestureAction(_ sender: UITapGestureRecognizer) {
        let currentTransform = imageView.transform
        let newTransform = currentTransform.scaledBy(x: 1.2, y: 1.2)
        imageView.transform = newTransform
        
        print("TAP GESTURE!!!")
    }
    
    @IBAction func twoFingersDoubleTapAction(_ sender: UITapGestureRecognizer) {
        let currentTransform = imageView.transform
        let newTransform = currentTransform.scaledBy(x: 0.8, y: 0.8)
        imageView.transform = newTransform
        
        print("TWO FINGERS TAP GESTURE!!!")
    }
    
    @IBAction func pinchGestureAction(_ sender: UIPinchGestureRecognizer) {
        
        if pinch.state == .began {
            testScale = 1
        }
        
        let newScale = 1.0 + pinch.scale - testScale
        let currentTransform = imageView.transform
        let newTransform = currentTransform.scaledBy(x: newScale, y: newScale)
        imageView.transform = newTransform
        testScale = pinch.scale
        
        print("PINCH GESTURE!!!")
    }
    
    @IBAction func panGestureAction(_ sender: UIPanGestureRecognizer) {
        //First way
        let translation = sender.translation(in: view)
        sender.view?.center.x += translation.x
        sender.view?.center.y += translation.y
        sender.setTranslation(.zero, in: view)
        
        //Second way
        //imageView.center = panGesture.location(in: view)
        
        print("PAN GESTURE!!!")
    }
    
    @IBAction func rotationGestureAction(_ sender: UIRotationGestureRecognizer) {
        
        if rotationGesture.state == .began {
            testRotation = 0
        }
        
        let newRotation = rotationGesture.rotation - testRotation
        let currentTransform = imageView.transform
        let newTransform = currentTransform.rotated(by: newRotation)
        imageView.transform = newTransform
        testRotation = rotationGesture.rotation
        
        print("ROTATION GESTURE!!!")
    }
    
    
    @IBAction func swipeGestureAction(_ sender: UISwipeGestureRecognizer) {

        UIView.animate(withDuration: 1) {
            self.imageView.center = self.view.center
        }
        
        print("SWIPE GESTURE!!!")
    }
    
    @IBAction func screenEdgePanGestureAction(_ sender: UIScreenEdgePanGestureRecognizer) {
        
        let randomColor = UIColor.init(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
        
        UIView.animate(withDuration: 2) {
            self.view.backgroundColor = randomColor
        }

        print("SCREEN EDGE PAN GESTURE!!!")
    }
    
    @IBAction func longPressGestureAction(_ sender: UILongPressGestureRecognizer) {
    
        UIView.animate(withDuration: 2) {
            self.view.backgroundColor = .white
        }
        
        print("LONG PRESS GESTURE!!!")
    }

    @IBAction func customGestureAction(_ sender: CustomGestureRecognizer) {
        UIView.animate(withDuration: 2) {
            self.view.backgroundColor = .black
        }
        
        print("CUSTOM GESTURE!!!")
    }

    
    //MARK: - UIViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tap.numberOfTapsRequired = 2
        swipeGesture.direction = .left
        screenEdgePanGesture.edges = .right
    }

}

