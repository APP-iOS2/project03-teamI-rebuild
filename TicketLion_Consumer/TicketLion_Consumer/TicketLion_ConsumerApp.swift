//
//  TicketLion_ConsumerApp.swift
//  TicketLion_Consumer
//
//  Created by 김종찬 on 2023/09/11.
//

import SwiftUI
import FirebaseCore
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            // 알림 권한 요청 결과 처리
            if granted {
                print("알림 권한이 허용되었습니다.")
                
            } else { print("알림 권한이 거부되었습니다.")
            }
        }
        
        
        
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct TicketLion_ConsumerApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainTabView()
            }
        }
    }
}
