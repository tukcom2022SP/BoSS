//
//  BossSpApp.swift
//  BossSp
//
//  Created by 이정동 on 2022/07/26.
//

import SwiftUI
import Firebase

@main
struct BossSpApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
  var body: some Scene {
        WindowGroup {
            //ContentView()
            LoadingView()
        }
    }
}
