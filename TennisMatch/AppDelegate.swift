//
//  AppDelegate.swift
//  TennisMatch
//
//  Created by 剱物蒼太 on 2018/11/16.
//  Copyright © 2018年 剱物蒼太. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseMessaging
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    var window: UIWindow?
    let userDefaults = UserDefaults.standard
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self as! MessagingDelegate
        
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self
        
        print(userDefaults.data(forKey: "idToken"))
        
        if userDefaults.object(forKey: "idToken") != nil {
            if userDefaults.object(forKey: "accessToken") != nil {
                self.window = UIWindow(frame: UIScreen.main.bounds)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let initialViewController = storyboard.instantiateViewController(withIdentifier: "mainView")
                self.window?.rootViewController = initialViewController
                self.window?.makeKeyAndVisible()
                print("値あり")
            } else {

            }
        }
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self as! UNUserNotificationCenterDelegate
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:])
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let _error = error {
            print(_error)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,  accessToken: authentication.accessToken)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ここに書くのはアプリがサーバーからの接続を切る時に実行する。例えばログアウト機能とか
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        if let messageID = userInfo["gcm.message_id"] {
            print("Message ID: \(messageID)")
        }
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if let messageID = userInfo["gcm.message_id"] {
            print("Message ID: \(messageID)")
        }
        print(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }
}

@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        if let messageID = userInfo["gcm.message_id"] {
            print("Message ID: \(messageID)")
        }
        print(userInfo)
        completionHandler([])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if let messageID = userInfo["gcm.message_id"] {
            print("Message ID: \(messageID)")
        }
        print(userInfo)
        completionHandler()
    }
}
