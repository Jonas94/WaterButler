//
//  SettingsBundleHelper.swift
//  WaterButler
//
//  Created by Jonas Fredriksson on 2021-05-13.
//

import Foundation

class SettingsBundleHelper {
    struct SettingsBundleKeys {
        static let Reset = "RESET_APP_KEY"
        static let AppVersionKey = "version_preference"
        static let piWaterUrl = "piwater_url"
    }
    class func checkAndExecuteSettings() {
        if UserDefaults.standard.bool(forKey: SettingsBundleKeys.Reset) {
            UserDefaults.standard.set(false, forKey: SettingsBundleKeys.Reset)
            let appDomain: String? = Bundle.main.bundleIdentifier
            UserDefaults.standard.removePersistentDomain(forName: appDomain!)

        }
    }
    
    class func setVersionAndBuildNumber() {
  
        let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        UserDefaults.standard.set(version, forKey: "version_preference")
    
    }
}
