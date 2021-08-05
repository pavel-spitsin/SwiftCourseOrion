//
//  PageViewController.swift
//  MyGallery
//
//  Created by Pavel Spitcyn on 04.08.2021.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {

    var viewControllersArray = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self

        for _ in 0..<3 {
            let vc = storyboard?.instantiateViewController(identifier: "FirstViewController") as! WelcomeViewController
            viewControllersArray.append(vc)
        }
        
        if let firstViewController = viewControllersArray.first {
                setViewControllers([firstViewController],
                                   direction: .forward,
                                   animated: true,
                                   completion: nil)
            }
        
    }
    
    
    //MARK: - UIPageViewControllerDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = viewControllersArray.firstIndex(of: viewController) else {
                    return nil
                }
                
                let previousIndex = viewControllerIndex - 1
                
                guard previousIndex >= 0 else {
                    return nil
                }
                
                guard viewControllersArray.count > previousIndex else {
                    return nil
                }
                
                return viewControllersArray[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = viewControllersArray.lastIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = viewControllersArray.count

        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return viewControllersArray[nextIndex]
        
    }

}

extension UIPageViewController {
    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        if let currentViewController = viewControllers?[0] {
            if let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) {
                setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
            }
        }
    }
}
