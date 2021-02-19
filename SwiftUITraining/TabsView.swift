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
                    Image(systemName: "books.vertical")
                    Text("Library")
                }
//            WishlistView()
//                .tabItem {
//                    Image(systemName: "square.and.pencil")
//                    Text("Wishlist")
//                }
            SuggestView().tabItem {
                    Image(systemName: "plus.circle")
                    Text("Suggest")
                }
        }
    }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
    }
}
