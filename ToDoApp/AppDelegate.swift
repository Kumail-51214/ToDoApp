//
//  AppDelegate.swift
//  ToDoApp
//
//  Created by Muhammad Kumail on 8/28/23.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        let nav = UINavigationController(rootViewController:ViewController())
        window?.rootViewController = nav
        nav.setNavigationBarHidden(true, animated: false)
        window?.makeKeyAndVisible()

        return true
    }
}
