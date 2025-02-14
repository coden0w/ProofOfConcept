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
        FirebaseApp.configure()
        requestNotificationPermission()
        Messaging.messaging().delegate = self
        return true
    }

    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }

    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error.localizedDescription)")
    }
    
    func requestNotificationPermission() {
        Task {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            do {
                let granted = try await center.requestAuthorization(options: [.alert, .badge, .sound])
                guard granted else {
                    print("Permission denied")
                    return
                }
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } catch {
                print("Failed to request permission: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - Extensions

extension AppDelegate: @preconcurrency MessagingDelegate {
    // Received FCM token to register it
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        guard let fcmToken else { return }
        print("FCM Token: \(fcmToken)")
    }
}

extension AppDelegate: @preconcurrency UNUserNotificationCenterDelegate {
    // MARK: - Shows notification when is received
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        [.badge, .banner, .sound]
    }

    // MARK: - Capture notification interaction
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse) async {
        let userInfo = response.notification.request.content.userInfo
        print("Notification received: \(userInfo)")
    }
}
