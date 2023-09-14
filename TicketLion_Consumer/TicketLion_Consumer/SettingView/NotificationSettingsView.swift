//
//  NotificationSettingsView.swift
//  TicketLion_Consumer
//
//  Created by 이승준 on 2023/09/12.
//

import SwiftUI
import UserNotifications

struct NotificationSettingsView: View {
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("알림 설정")) {
                    Button("알림 허용 설정") {
                        openAppNotificationSettings()
                        let notificationTime = Date().addingTimeInterval(15)
                        scheduleLocalNotification(at: notificationTime, withTitle: "Ticket Lion", andBody: "새로운 새미나를 만나보세요!")
                    }
                }
            }
        }
        .navigationTitle("알림 설정")
    }
}

// iOS 설정 앱을 열어 앱의 알림 설정 페이지로 이동
private func openAppNotificationSettings() {
    guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
    UIApplication.shared.open(settingsURL)
}

// 알림을 예약하는 함수
func scheduleLocalNotification(at date: Date, withTitle title: String, andBody body: String) {
    let content = UNMutableNotificationContent()
    content.title = title
    content.body = body
    content.sound = UNNotificationSound.default
    
    let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
    let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
    
    let request = UNNotificationRequest(identifier: "localNotification", content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request) { error in
        if let error = error {
            print("로컬 알림 예약 실패: \(error.localizedDescription)")
        } else {
            print("로컬 알림이 예약되었습니다.")
        }
    }
}

// 예약된 알림을 취소하는 함수
func cancelScheduledLocalNotification() {
    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["localNotification"])
}



struct NotificationSettingView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationSettingsView()
    }
}
