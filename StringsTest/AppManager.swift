//
//  AppManager.swift
//  StringsTest
//
//  Created by Vadym Yankovskiy on 5/6/18.
//  Copyright © 2018 Vadym Yankovskiy. All rights reserved.
//

import UIKit

let stringAmountRange = 100...200
let stringLengthRange = 50...200

class AppManager {
    static let sharedInstance = AppManager()
    var window: UIWindow!
    
    func start(with window: UIWindow?){
        guard let window = window else { return }
        
        self.window = window
        presentRootVC()
    }
    
    private func presentRootVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let identifier = String(describing: StringsTableViewController.self)
        let rootVC = storyboard.instantiateViewController(withIdentifier: identifier) as! StringsTableViewController
        let stringsRouter = StringsTableRouter(withModels: generateStrings(length: stringLengthRange, amount: stringAmountRange))
        rootVC.router = stringsRouter
        
        window.rootViewController = rootVC
    }
}

