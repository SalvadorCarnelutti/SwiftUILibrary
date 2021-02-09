//
//  TabsView.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 09/02/2021.
//

import SwiftUI

struct TabsView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Library")
                }
//            WishlistView()
//                .tabItem {
//                    Image(systemName: "square.and.pencil")
//                    Text("Wishlist")
//                }
        }
    }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
    }
}
