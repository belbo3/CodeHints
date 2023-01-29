//
//  AppDelegate similar.swift
//  PushTest
//
//  Created by Oleksandr Yakobshe on 29.01.2023.
//

import UIKit
import FirebaseCore
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

		var window: UIWindow?
		
		func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
				self.window = UIWindow(frame: UIScreen.main.bounds)
				window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
				window?.makeKeyAndVisible()

				// MARK: - подлючаем фаербейс
				FirebaseApp.configure()
				
				// MARK: - запрашиваем пермишин на пуши и подвязываем делегаты
				registerPush(application)
				
				return true
		}
		
		func applicationDidBecomeActive(_ application: UIApplication) {
				// MARK: - чистим показатель Badge при входе в приложение
				UIApplication.shared.applicationIconBadgeNumber = 0
		}
		
		private func registerPush(_ application: UIApplication) {
				Messaging.messaging().delegate = self
				UNUserNotificationCenter.current().delegate = self
				
				UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
						success, error in
						guard success else { return }
				}
				application.registerForRemoteNotifications()
		}
}


// MARK: - UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {
		func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
				Messaging.messaging().apnsToken = deviceToken
				let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
				print(token)
		}
	
		func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
				return [[.alert, .sound, .badge]]
		}
	
		func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) async -> UIBackgroundFetchResult {
				return UIBackgroundFetchResult.newData
		}
}

// MARK: - MessagingDelegate
extension AppDelegate: MessagingDelegate {
		func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
				print("Firebase registration token: \(String(describing: fcmToken))")

				let dataDict: [String: String] = ["token": fcmToken ?? ""]
				NotificationCenter.default.post(name: Notification.Name("FCMToken"),
																				object: nil,
																				userInfo: dataDict)
		}
}
