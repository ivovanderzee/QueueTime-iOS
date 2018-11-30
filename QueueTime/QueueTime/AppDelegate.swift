//
//  AppDelegate.swift
//  QueueTime
//
//  Created by Ivo van der Zee on 06/11/2018.
//  Copyright © 2018 Ivo van der Zee. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications
import FBSDKLoginKit
import FBSDKCoreKit
import Intents


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FBSDKApplicationDelegate.sharedInstance()?.application(application, didFinishLaunchingWithOptions: launchOptions)
    
        
        FirebaseApp.configure()
        

        
        //dit stukje code zorgt ervoor dat er notificaties verstuurd mogen worden vanaf de app naar het iOS systeem // Rens
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound])
            {(succes, error) in
                if error !=  nil{
                    print("Autorisatie niet succesvol")
                }else{
                    print("Autorisatie is succesvol")
                    
                }
            }
            
        return true
        
            
        }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        guard let intent = userActivity.interaction?.intent as? INAskSiriIntent else {
            print("AppDelegate: Ik sta in de file - FALSE")
            return false
        }
        print("AppDelegate: Ik sta in de file - TRUE")
        print(intent)
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }

    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

