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
    private static var wishlistURL = "https://www.googleapis.com/books/v1/mylibrary/bookshelves/2/volumes"
    private static var viewedURL = "https://www.googleapis.com/books/v1/mylibrary/bookshelves/3/volumes"
    private var tasks: Set<AnyCancellable> = []
    
    // Publishers must be stored or otherwise ARC swoops by and deallocates them immediately
    @Published var loading: Bool = true
    @Published var wishlistBooks: [Book] = [] {
        didSet {
            loading = false
        }
    }
    @Published var recentlyViewedBooks: [Book] = [] {
        didSet {
            loading = false
        }
    }

        
    init(wishlistBooks: [Book] = []) {
        self.wishlistBooks = wishlistBooks
    }
        
    func getWishlistBooks() {
        guard let currentUser = GIDSignIn.sharedInstance.currentUser else { return }
        
        currentUser.refreshTokensIfNeeded { [weak self] user, error in
            guard error == nil,
            let user = user,
            let self = self else { return }

            // Get the access token to attach it to a REST or gRPC request.
            let accessToken = user.accessToken.tokenString
            
            var request =  URLRequest(url: URL(string: Self.wishlistURL)!)
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
                .store(in: &self.tasks)
        }
    }
    
    func getRecentlyViewedBooks() {
        guard let currentUser = GIDSignIn.sharedInstance.currentUser else { return }
        
        currentUser.refreshTokensIfNeeded { [weak self] user, error in
            guard error == nil,
            let user = user,
            let self = self else { return }

            let accessToken = user.accessToken.tokenString
            
            var request =  URLRequest(url: URL(string: Self.viewedURL)!)
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
                .store(in: &self.tasks)
        }
    }
}
