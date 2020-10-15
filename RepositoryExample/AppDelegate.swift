//
//  AppDelegate.swift
//  RepositoryExample
//
//  Created by Aleksey on 10/12/20.
//  Copyright © 2020 byMishko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    //var mainCoordinator: FlowCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let root = MainFlowCoordinator(parent: nil).startFlow()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = root
        window?.makeKeyAndVisible()
        
        return true
    }

}
