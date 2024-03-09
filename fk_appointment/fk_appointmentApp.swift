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

    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}
