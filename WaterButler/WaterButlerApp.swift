//
//  WaterButlerApp.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-04-30.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct WaterButlerApp: App {
    @StateObject var viewModel = AuthenticationViewModel()

    init() {
        FirebaseApp.configure()
        SettingsBundleHelper.checkAndExecuteSettings()
        SettingsBundleHelper.setVersionAndBuildNumber()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID

    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
    
}

