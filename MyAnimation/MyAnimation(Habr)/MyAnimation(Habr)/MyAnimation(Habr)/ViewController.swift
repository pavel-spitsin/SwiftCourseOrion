//
//  ViewController.swift
//  MyAnimation(Habr)
//
//  Created by Pavel Spitcyn on 15.06.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var animationButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func startAnimation(_ sender: UIButton) {
        
        //animation1()
        //animation2()
        //animation3()
        //animation4()
        //animation5()
        //animation6()
        animation7()
        //animation8()
  
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    //MARK: - Functions
    
    func animation1() {
        let theAnimation = CABasicAnimation(keyPath: "position");

        theAnimation.fromValue = NSValue(cgPoint: CGPoint(x: view.frame.width/2, y: animationButton.frame.origin.y))
        theAnimation.toValue = NSValue(cgPoint: CGPoint(x: 100.0, y: 100.0))
        theAnimation.duration = 3.0;
        theAnimation.autoreverses = false //true - возвращает в исходное значение либо плавно, либо нет
        theAnimation.repeatCount = 2
        animationButton.layer.add(theAnimation, forKey: "animatePosition")
    }
    
    func animation2() {
        let animation = CAKeyframeAnimation()

        let pathArray = [NSValue(cgPoint: CGPoint(x: 10.0, y: 10.0)),
                         NSValue(cgPoint: CGPoint(x: 100.0, y: 100.0)),
                         NSValue(cgPoint: CGPoint(x: 10.0, y: 100.0)),
                         NSValue(cgPoint: CGPoint(x: 10.0, y: 10.0))]

        animation.keyPath = "position"
        animation.values = pathArray
        animation.duration = 5.0
        animationButton.layer.add(animation, forKey: "position")
    }
    
    func animation3() {
        let transition = CATransition()

        transition.duration = 2.35
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(ViewController(), animated: false)
    }
    
    func animation4() {
        var animations = [CABasicAnimation]()

        let posAnimation = CABasicAnimation(keyPath: "position")
        posAnimation.duration = 10.0
        posAnimation.autoreverses = true
        posAnimation.fromValue = NSValue(cgPoint: CGPoint(x: animationButton.frame.origin.x,
                                                           y: animationButton.frame.origin.y))
        posAnimation.toValue = NSValue(cgPoint: CGPoint(x: 100.0, y: 100.0))
        animations.append(posAnimation)
                
        
        let heightAnimation = CABasicAnimation(keyPath: "bounds.size")
        heightAnimation.autoreverses = true
        heightAnimation.duration = 10.0
        heightAnimation.fromValue =  NSValue(cgSize: CGSize(width: animationButton.frame.size.width,
                                                            height: animationButton.frame.size.height))
        heightAnimation.toValue = NSValue(cgSize: CGSize(width: animationButton.frame.size.width,
                                                         height: 300.0))
        heightAnimation.beginTime = 5.0
        animations.append(heightAnimation)
                
        let group = CAAnimationGroup()

        group.duration = 10.0
        group.animations = animations
        animationButton.layer.add(group, forKey: nil)
    }
    
    func animation5() {
        UIView.animate(withDuration: 3.0) {
            self.animationButton.alpha = 0.0
        }
    }
    
    func animation6() {
        var frame = animationButton.frame
        frame.origin.y = 100
        frame.size.height = 200
                
        UIView.animate(withDuration: 1.5, delay: 0.0, options: .curveEaseOut, animations: {
        self.animationButton.frame = frame
        }) { (true) in
        print("Done")
        }
    }
    
    func animation7() {
        UIView.transition(with: self.view,
                          duration: 1.5,
                          options: .transitionFlipFromBottom,
                          animations: {
                            self.view.addSubview(self.imageView)
        }, completion: nil)
    }
    
    func animation8() {
        var imgListArray :NSMutableArray = []
        for countValue in 1...8 {
        var strImageName : String = "chicken_normal_fly_\(countValue).png"
        var image = UIImage(named:strImageName)
        imgListArray.add(image as Any)
        }

        //imageView.animationImages = imgListArray;
        imageView.animationDuration = 0.25
        imageView.startAnimating()
    }
    

}

