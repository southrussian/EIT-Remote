//
//  EIT_RemoteApp.swift
//  EIT-Remote
//
//  Created by Danil Peregorodiev on 29.11.2022.
//

import SwiftUI
import Firebase

@main
struct EIT_RemoteApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
//            SplashScreenView()
            if let user = AuthService.shared.currentUser {
                if user.uid == "Ld6mrPcoxzZHyHKvGEEkmUE2d253" {
                    AdminOrdersView()
                } else {
                    let viewModel = TabViewModel(user: user)
                    Tab(viewModel: viewModel)
                }
            } else {
                AuthView()
            }
        }
    }
}


