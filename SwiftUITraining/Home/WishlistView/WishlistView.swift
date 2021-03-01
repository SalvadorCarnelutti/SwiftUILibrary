//
//  WishlistView.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 22/02/2021.
//

import SwiftUI

struct WishlistView: View {
    @StateObject var wishlistViewModel = WishlistViewModel()
    
    var body: some View {
        NavigationView {
            BookTableView(books: wishlistViewModel.wishlistBooks.map { $0.book })
            VStack {
                SuggestionView(urlLinks: wishlistViewModel.wishlistBooks.map { $0.book.image })
                Spacer()
            }
            .background(Color.lavender.edgesIgnoringSafeArea(.bottom))
            .navigationTitle("WISHLIST")
            .onAppear {
                wishlistViewModel.getWishlistBooks()
            }
        }
    }
}

struct WishlistView_Previews: PreviewProvider {
    static var previews: some View {
        WishlistView()
    }
}
