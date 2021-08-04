//
//  PageViewController.swift
//  MyGallery
//
//  Created by Pavel Spitcyn on 04.08.2021.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    var vcs = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        dataSource = self

        for _ in 0..<3 {
            let vc = storyboard?.instantiateViewController(identifier: "FirstViewController") as! WelcomeViewController
            vc.pageVC = self
            vcs.append(vc)
        }
        
        if let firstViewController = vcs.first {
                setViewControllers([firstViewController],
                                   direction: .forward,
                                   animated: true,
                                   completion: nil)
            }
        
    }
    
    
    //MARK: - UIPageViewControllerDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = vcs.firstIndex(of: viewController) else {
                    return nil
                }
                
                let previousIndex = viewControllerIndex - 1
                
                guard previousIndex >= 0 else {
                    return nil
                }
                
                guard vcs.count > previousIndex else {
                    return nil
                }
                
                return vcs[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = vcs.lastIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = vcs.count

        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return vcs[nextIndex]
        
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
