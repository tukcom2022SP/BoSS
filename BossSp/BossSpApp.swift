//
//  BossSpApp.swift
//  BossSp
//
//  Created by 이정동 on 2022/07/26.
//

import SwiftUI
import FirebaseCore // 파이어베이스

// 파이어베이스
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}


@main
struct BossSpApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate // 파이어베이스
    
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
            MapView()
        }
    }
}
