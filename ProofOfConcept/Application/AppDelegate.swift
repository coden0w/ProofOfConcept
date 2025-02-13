//
//  AppDelegate.swift
//  ProofOfConcept
//
//  Created by Alexandru Robert Blaga on 13/2/25.
//

import Foundation
import SwiftUI
import FirebaseCore
import FirebaseMessaging

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // MARK: - Firebase
        
        FirebaseApp.configure()
        requestNotificationAuthorization()
        
        return true
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("[UNUserNotificationCenter] -> Error to register: \(error.localizedDescription)")
    }
    
    func requestNotificationAuthorization() {
        Task {
            let notificationCenterStatus = UNUserNotificationCenter.current()
            notificationCenterStatus.delegate = self
            do {
                 let granted = try await notificationCenterStatus.requestAuthorization(options: [.alert, .badge, .sound])
                guard granted else {
                    print("[UNUserNotificationCenter] -> Permission status: \(granted)")
                    return
                }
            } catch {
                print("[UNUserNotificationCenter] -> Error trying to request Notification Authorization \(error)")
            }
        }
    }
    
}

// MARK: - Extensions

extension AppDelegate: @preconcurrency UNUserNotificationCenterDelegate, @preconcurrency MessagingDelegate {
    
    // MARK: - UNUserNotificationCenterDelegate
    
    /// Present notification on receive
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        [.badge, .banner, .sound]
    }
    
    /// Capture notification body
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse) async {
        let userInfo = response.notification.request.content.userInfo
        print("[UNUserNotificationCenter] -> didReceive response: \(userInfo)")
    }
    
    
    // MARK: - MessagingDelegate
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        guard let fcmToken else { return }
        print("[MessagingDelegate] -> FCM Token: \(fcmToken)")
    }
}
