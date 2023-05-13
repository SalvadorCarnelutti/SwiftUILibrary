//
//  WishlistViewModel.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 25/02/2021.
//

import Combine
import Foundation
import GoogleSignIn

class WishlistViewModel: ObservableObject {
    // TODO: Fix wishlist and suggest navbar color
    private static var wishlistedURL = "https://www.googleapis.com/books/v1/mylibrary/bookshelves/2/volumes"
    private static var recentlyViewedURL = "https://www.googleapis.com/books/v1/mylibrary/bookshelves/3/volumes"
    private var cancellableSet: Set<AnyCancellable> = []
    
    // Publishers must be stored or otherwise ARC swoops by and deallocates them immediately
    @Published var isLoading: Bool = true
    @Published var wishlistBooks: [Book] = [] {
        didSet {
            isWishlistedLoading = false
        }
    }
    @Published var recentlyViewedBooks: [Book] = [] {
        didSet {
            isRecentlyViewedLoading = false
        }
    }
    
    @Published private var isWishlistedLoading: Bool = true
    @Published private var isRecentlyViewedLoading: Bool = true
        
    init(wishlistBooks: [Book] = [], recentlyViewedBooks: [Book] = []) {
        self.wishlistBooks = wishlistBooks
        self.recentlyViewedBooks = recentlyViewedBooks
        self.publishIsLoading()
    }
        
    func getWishlistBooks() {
        guard let currentUser = GIDSignIn.sharedInstance.currentUser else { return }
        
        isWishlistedLoading = true
        currentUser.refreshTokensIfNeeded { [weak self] user, error in
            guard error == nil,
            let user = user,
            let self = self else { return }

            // Get the access token to attach it to a REST or gRPC request.
            let accessToken = user.accessToken.tokenString
            
            var request =  URLRequest(url: URL(string: Self.wishlistedURL)!)
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTaskPublisher(for: request)
                .map { $0.data }
                .decode(type: Items.self, decoder: JSONDecoder())
                .map(\.items)
                // Print is for debugging petition contents
                .print()
                .replaceError(with: [])
                .eraseToAnyPublisher()
                .receive(on: RunLoop.main)
                .assign(to: \WishlistViewModel.wishlistBooks, on: self)
                .store(in: &self.cancellableSet)
        }
    }
    
    func getRecentlyViewedBooks() {
        guard let currentUser = GIDSignIn.sharedInstance.currentUser else { return }
        
        isRecentlyViewedLoading = true
        currentUser.refreshTokensIfNeeded { [weak self] user, error in
            guard error == nil,
            let user = user,
            let self = self else { return }

            let accessToken = user.accessToken.tokenString
            
            var request =  URLRequest(url: URL(string: Self.recentlyViewedURL)!)
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTaskPublisher(for: request)
                .map { $0.data }
                .decode(type: Items.self, decoder: JSONDecoder())
                .map(\.items)
                // Print is for debugging petition contents
                .print()
                .replaceError(with: [])
                .eraseToAnyPublisher()
                .receive(on: RunLoop.main)
                .assign(to: \WishlistViewModel.recentlyViewedBooks, on: self)
                .store(in: &self.cancellableSet)
        }
    }
    
    private func publishIsLoading() {
        /*
         .allSatisfy can't be used because Apple's documentation states:
         "If the predicate returns false, the publisher produces a false value and finishes."
         And we want to continously keep the stream alive to notice further changes.
         */
        Publishers.CombineLatest($isWishlistedLoading, $isRecentlyViewedLoading)
            .map { l1, l2 in
                l1 || l2
            }
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: self)
            .store(in: &cancellableSet)
    }

}
