//
//  AppDelegate.swift
//  Puppies
//
//  Created by Kevin Finn on 11/16/14.
//  Copyright (c) 2014 Heptarex. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let vc = ViewController()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        if window == nil {
            window = UIWindow(frame: UIScreen.mainScreen().bounds)
        }
        
        window?.rootViewController = vc
        window?.userInteractionEnabled = true
        window?.makeKeyAndVisible()
        
        NSURLCache.setSharedURLCache(NSURLCache())
        
        return true
    }
}

