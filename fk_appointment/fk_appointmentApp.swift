//
//  fk_appointmentApp.swift
//  fk_appointment
//
//  Created by Furkan on 15.10.2023.
//

import SwiftUI
import Firebase

@main
struct fk_appointmentApp: App {
    init(){
        FirebaseApp.configure()
    }
    @StateObject var appState = AppState()
    var body: some Scene {
        
        WindowGroup {
            
             if appState.shouldShowLoginView == false {
                SplashView().environmentObject(appState)
            } else {
                SplashView().environmentObject(appState)
            }
           
        }
    }
}
class AppState: ObservableObject {
    @Published var shouldShowLoginView = false
}

