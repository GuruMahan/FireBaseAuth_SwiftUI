//
//  FireBaseAuthWithoutPod_POCApp.swift
//  FireBaseAuthWithoutPod POC
//
//  Created by Guru Mahan on 09/02/23.
//

import SwiftUI
import Firebase
@main



struct FireBaseAuthWithoutPod_POCApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            if UserDefaults.standard.bool(forKey: "islogin"){
                DashboardView()
                  
            }else{
                LoginView()
            
            }
          
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseApp.configure()

    return true
  }
}
