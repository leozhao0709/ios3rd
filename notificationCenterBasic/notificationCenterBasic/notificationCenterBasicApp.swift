//
//  notificationCenterBasicApp.swift
//  notificationCenterBasic
//
//  Created by Lei Zhao on 11/2/20.
//
//

import SwiftUI

@main
struct notificationCenterBasicApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
              .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                  print("App退到后台了")
              }
              .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                  print("App回到前台了")
              }
              .onReceive(NotificationCenter.default.publisher(for: UIApplication.userDidTakeScreenshotNotification)) { _ in
                  print("用户截屏了")
              }
              .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification)) { _ in
                  print("软键盘出来了")
              }
        }
    }
}
