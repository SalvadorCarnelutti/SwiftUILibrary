//
//  SwiftUITrainingApp.swift
//  SwiftUITraining
//
//  Created by Diego Quiros on 15/10/2020.
//

import SwiftUI

@main
struct SwiftUITrainingApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}

/*
 TabView  {
 HomeView()
         .tabItem {
             Image(systemName: "list.dash")
             Text("Library")
         }
     WishlistView()
         .tabItem {
             Image(systemName: "square.and.pencil")
             Text("Wishlist")
         }
     ...
 }
 */
