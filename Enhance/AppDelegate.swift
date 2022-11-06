//
//  AppDelegate.swift
//  Enhance
//
//  Created by Michael Gillund on 3/31/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//
import UIKit
import Firebase
import UserNotifications
import Messages
import FirebaseMessaging



@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let gcmMessageIDKey = "gcm.message_id"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        
        //Configuration
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.badge, .sound, .alert]) { (granted, error) in
            //granted = yes, if app is authorized for all of the requested interaction types
            //granted = no, if one or more interaction type is disallowed
        }
 
        UINavigationBarAppearance().shadowColor = .clear
//        UINavigationBar.appearance().barTintColor = .black
//        UINavigationBar.appearance().shadowImage = UIImage()
//        UITabBar.appearance().backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
//        UITabBar.appearance().backgroundImage = UIImage()
        
//        UITabBar.appearance().barTintColor = .black
//        UITabBar.appearance().unselectedItemTintColor = .black
//        UITabBar.appearance().isTranslucent = true
//        UITabBar.appearance().shadowImage = UIImage()
//        UITabBar.appearance().clipsToBounds   = true
        
        return true
//        UIColor(red: 0.00, green: 0.38, blue: 0.97, alpha: 1.00) :BLUE
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
      // If you are receiving a notification message while your app is in the background,
      // this callback will not be fired till the user taps on the notification launching the application.
      // TODO: Handle data of notification
      // With swizzling disabled you must let Messaging know about the message, for Analytics
      // Messaging.messaging().appDidReceiveMessage(userInfo)
      // Print message ID.
      if let messageID = userInfo[gcmMessageIDKey] {
        print("MESSAGE ID: \(messageID)")
      }
      // Print full message.
//      print(userInfo)
      completionHandler(UIBackgroundFetchResult.newData)
    }
    func application( _ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
      print("UNABLE TO REGISTER REMOTE NOTIFICATIONS: (error.localizedDescription)")
    }

    // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
    // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
    // the FCM registration token.
    func application( _ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      print("APNs TOKEN: \(deviceToken)")
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("FIREBASE REGISTRATION TOKEN: \(fcmToken)")

      let dataDict:[String: String?] = ["token": fcmToken]
      NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
}
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {

  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    let userInfo = notification.request.content.userInfo

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)
    // Print message ID.
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }

    // Print full message.
//    print(userInfo)

    // Change this to your preferred presentation option
    completionHandler([.alert, .sound, .badge])
  }
}

