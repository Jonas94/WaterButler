//
//  WaterButlerApp.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-04-30.
//

import SwiftUI
import Firebase

@main
struct WaterButlerApp: App {
    
    init() {
        FirebaseApp.configure()
        SettingsBundleHelper.checkAndExecuteSettings()
        SettingsBundleHelper.setVersionAndBuildNumber()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
}

