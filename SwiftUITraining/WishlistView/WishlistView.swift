//
//  WishlistView.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 22/02/2021.
//

import SwiftUI

struct WishlistView: View {
    @StateObject var wishlistViewModel: WishlistViewModel
    @EnvironmentObject var vm: UserStateViewModel
    
    var body: some View {
        LoadingView(isShowing: $wishlistViewModel.loading) {
            NavigationView {
                VStack {
                    BookTableView(books: wishlistViewModel.wishlistBooks)
                    RecentBooksView(books: wishlistViewModel.recentlyViewedBooks)
                    Spacer()
                }
                .navigationTitle("WISHLIST")
                .toolbar {
                    LogoutButton(buttonAction: vm.signOut)
                }
                .background(Color.lavender)
                .onAppear {
                    wishlistViewModel.getWishlistBooks()
                    wishlistViewModel.getRecentlyViewedBooks()
                }
            }
        }
    }
}

struct WishlistView_Previews: PreviewProvider {
    static var previews: some View {
        let mockViewModel = WishlistViewModel(wishlistBooks: Book.getMockedWishlistBooks())
        let vm = UserStateViewModel.getMock(loggedIn: true)
        
        WishlistView(wishlistViewModel: mockViewModel)
            .environmentObject(vm)
    }
}
