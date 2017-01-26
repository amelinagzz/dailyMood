//
//  AppDelegate.swift
//  dailymood
//
//  Created by Adriana Gonzalez on 1/11/17.
//  Copyright © 2017 AMGM. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import WatchConnectivity
import RealmSwift
import NotificationCenter

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WCSessionDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        Fabric.with([Crashlytics.self])
        
        if WCSession.isSupported(){
            WCSession.default().delegate = self
            WCSession.default().activate()
        }
        
        return true
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

    //Watch connectivity
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if error != nil {
            print("Error: \(error)")
        }else{
            print("Ready to communicate with apple watch.")
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("Inactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("Deactivated")
        WCSession.default().activate()

    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        print("This is the user info \(userInfo)")
        
        //Create Mood object and save it into realm
        
        let mood = Mood()
        
        guard let date = userInfo["date"] as? NSDate, let name = userInfo["name"] as? String else{
            return
        }
        mood.name = name
        mood.date = date
        
        let realm = try! Realm()
        
        
        try! realm.write {
            realm.add(mood)
        }
        
        //Send notification
        
        let notification = Notification(name:Notification.Name(rawValue: "gotNewMood"))
        NotificationCenter.default.post(notification)
    }
    

}

