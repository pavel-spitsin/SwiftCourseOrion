//
//  SplitViewController.swift
//  MyToDo
//
//  Created by Павел on 11.08.2021.
//

import UIKit

class SplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.delegate = self
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            preferredDisplayMode = .oneBesideSecondary
            if #available(iOS 14, *) {
                preferredSplitBehavior = .tile
            }
        }
    }
    
    
    //MARK: - UISplitViewControllerDelegate
    
    public func splitViewController(_ svc: UISplitViewController,
        topColumnForCollapsingToProposedTopColumn
        proposedTopColumn: UISplitViewController.Column) -> UISplitViewController.Column {
        return .primary
    }

    public func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController:UIViewController,
                             onto primaryViewController:UIViewController) -> Bool {
        return true
    }
}

