//
//  Chef_MakerApp.swift
//  Chef Maker
//
//  Created by Rovshan Rasulov on 05.04.25.
//

import SwiftUI
import FirebaseCore
import FirebaseAppCheck


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      
      #if DEBUG
      AppCheck.setAppCheckProviderFactory(AppCheckDebugProviderFactory())
      #endif
      
    return true
  }
}

@main
struct MyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
   // @StateObject var authState = AuthState()
    
    var body: some Scene {
        WindowGroup {
            AnimatedLogoScreen()
        }
    }
}
