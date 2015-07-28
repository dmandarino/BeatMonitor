//
//  AppDelegate.swift
//  BeatMonitor
//
//  Created by Douglas Mandarino on 7/21/15.
//  Copyright (c) 2015 Douglas Mandarino. All rights reserved.
//

import UIKit
import HealthKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var navigationController:UINavigationController!
    
    var mainViewController =  ViewController()
    
    let healthStore: HKHealthStore = HKHealthStore()
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.Default, animated: false)
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        self.navigationController = UINavigationController(rootViewController: self.mainViewController)
        
        //        navigationController!.navigationBar.barTintColor = UIColor(red: 1.0000, green: 0.8824, blue: 0.7843, alpha: 1.0)
        //        navigationController!.navigationBar.alpha = 1.0
        //        navigationController!.navigationBar.tintColor = UIColor.blackColor()
        //        navigationController!.navigationBar.layer.borderWidth = 0
        //        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont(name: "Helvetica Neue", size: 22)! , NSForegroundColorAttributeName: UIColor.blackColor()]
        
        self.window?.rootViewController = self.navigationController
        self.window?.makeKeyAndVisible()
        
        
        // Override point for customization after application launch.
        
        if(UIApplication.instancesRespondToSelector(Selector("registerUserNotificationSettings:"))) {

            application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil))
        }
        
        return true
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        application.applicationIconBadgeNumber = 0
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func applicationShouldRequestHealthAuthorization(application: UIApplication) {
        
        self.healthStore.handleAuthorizationForExtensionWithCompletion { success, error in
            
            
        }
    }


}

