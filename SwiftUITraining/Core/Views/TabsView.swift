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
            LibraryView(libraryViewModel: LibraryViewModel())
                .tabItem {
                    Image(systemName: "books.vertical")
                    Text("Library")
                }
            WishlistView(wishlistViewModel: WishlistViewModel())
                .tabItem {
                    Image(systemName: "star.square")
                    Text("Wishlist")
                }
            SuggestView()
                .tabItem {
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
