//
//  SwiftUITrainingApp.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 15/10/2020.
//

import SwiftUI
import GoogleSignIn

@main
struct SwiftUITrainingApp: App {
    @StateObject var userStateViewModel = UserStateViewModel()

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
                .environmentObject(userStateViewModel)
        }
    }
}
