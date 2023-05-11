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
                        .navigationTitle("WISHLIST")
                        .onAppear {
                            wishlistViewModel.getWishlistBooks()
                            wishlistViewModel.getRecentlyViewedBooks()
                        }
                    RecentBooksView(books: wishlistViewModel.recentlyViewedBooks)
                    Spacer()
                        .toolbar {
                            LogoutButton(buttonAction: vm.signOut)
                        }
                }
                .background(Color.lavender)
            }
        }
    }
}

//struct WishlistView_Previews: PreviewProvider {
//    static var previews: some View {
//        let mockViewModel = WishlistViewModel(wishlistBooks: Book.getMockedWishlistBooks())
//        
//        WishlistView(wishlistViewModel: mockViewModel)
//    }
//}
