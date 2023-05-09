//
//  SwiftUITrainingApp.swift
//  SwiftUITraining
//
//  Created by Diego Quiros on 15/10/2020.
//

import SwiftUI
import GoogleSignIn

@main
struct SwiftUITrainingApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView()
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
                .onAppear {
                    GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                        // Check if `user` exists; otherwise, do something with `error`
                    }
                }
        }
    }
}
