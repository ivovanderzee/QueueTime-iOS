//
//  AppDelegate.swift
//  QueueTime
//
//  Created by Ivo van der Zee on 06/11/2018.
//  Copyright © 2018 Ivo van der Zee. All rights reserved.
//


//All libraries that are used in this viewcontroller
import UIKit
import Firebase
import UserNotifications
import FBSDKLoginKit
import FBSDKCoreKit
import Intents


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FBSDKApplicationDelegate.sharedInstance()?.application(application, didFinishLaunchingWithOptions: launchOptions)
    
        
        //The firebase configured in the appdelegate so every viewcontroller can access this function
        FirebaseApp.configure()
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification sent via Apple Push Notification service
            UNUserNotificationCenter.current().delegate = self
            
            // Allows different kinds of alerts for user
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            
            // The app request the user for usernotificcations for the different notifications that are selected in authOptions
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: {_, _ in})
           
            
        }else{
            
            // Notification settings are set on default because no category is set
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        // notification comes from a remote. This remote is FireBase
        application.registerForRemoteNotifications()

        
       
            
        return true
        
        
        }
    

    
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        
        // AudioCAllIntent is created
        guard let audioCallIntent = userActivity.interaction?.intent as? INStartAudioCallIntent else {
            return false
        }
        
        // Picks contacts
        if let contact = audioCallIntent.contacts?.first {
            
            
            // Picks phonenumber
            if let type = contact.personHandle?.type, type == .phoneNumber {
                
                // If there is no phonenumber, no value returns
                guard let callNumber = contact.personHandle?.value else {
                    return false
                }
                
                // Phonenumber is put into a type of URL
                let callUrl = URL(string: "tel://\(callNumber)")
                
                // If its possible to open it opens
                if UIApplication.shared.canOpenURL(callUrl!) {
                    UIApplication.shared.open(callUrl!, options: [:], completionHandler: nil)
                    
                    
                    // If it is not possible to open it there will be a alert message in the default style
                } else {
                    
                    let alertController = UIAlertController(title: nil , message: "Calling not supported", preferredStyle: .alert)
                    let okAlertAction = UIAlertAction(title: "Ok" , style: UIAlertAction.Style.default, handler:nil)
                    alertController.addAction(okAlertAction)
                    self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
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

