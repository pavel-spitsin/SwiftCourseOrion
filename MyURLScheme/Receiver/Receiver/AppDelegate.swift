//
//  AppDelegate.swift
//  Receiver
//
//  Created by Pavel Spitcyn on 30.06.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureInitialViewController()
        return true
    }

    private func configureInitialViewController() {
        let initialViewController: UIViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        window = UIWindow()

        let mainViewController = storyboard.instantiateViewController(withIdentifier: "main")
        initialViewController = mainViewController
        
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let text = url.host?.removingPercentEncoding
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let vc = appDelegate.window!.rootViewController as! ViewController
        vc.textLabel.text = text
  
        return true
    }
    
}

