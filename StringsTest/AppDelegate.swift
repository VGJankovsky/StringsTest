//
//  AppDelegate.swift
//  StringsTest
//
//  Created by Vadym Yankovskiy on 5/6/18.
//  Copyright © 2018 Vadym Yankovskiy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        AppManager.sharedInstance.start(with: self.window)
        
        return true
    }


}

