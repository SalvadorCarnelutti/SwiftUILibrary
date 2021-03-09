//
//  WishlistView.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 22/02/2021.
//

import SwiftUI

struct WishlistView: View {
    @StateObject private var _wishlistViewModel = WishlistViewModel()
    
    var body: some View {
        NavigationView {
            BookTableView(books: _wishlistViewModel.wishlistBooks.map { $0.book })
            VStack {
                SuggestionView(urlLinks: _wishlistViewModel.wishlistBooks.map { $0.book.image })
                Spacer()
            }
            .background(Color.lavender.edgesIgnoringSafeArea(.bottom))
            .navigationTitle("WISHLIST")
            .onAppear {
                _wishlistViewModel.getWishlistBooks()
            }
        }
    }
}

struct WishlistView_Previews: PreviewProvider {
    static var previews: some View {
        WishlistView()
    }
}
