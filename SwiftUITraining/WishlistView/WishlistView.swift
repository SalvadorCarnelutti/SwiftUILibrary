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
                        .background(Color.lavender.edgesIgnoringSafeArea(.bottom))
                        .navigationTitle("WISHLIST")
                        .onAppear {
                            wishlistViewModel.getWishlistBooks()
                        }
                    SuggestionView(books: wishlistViewModel.wishlistBooks)
                    Spacer()
                        .toolbar {
                            LogoutButton(buttonAction: vm.signOut)
                        }
                }
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
