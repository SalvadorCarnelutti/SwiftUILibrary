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
    // TODO: Fix loader issue pushing things up
    private static var wishlistedURL = "https://www.googleapis.com/books/v1/mylibrary/bookshelves/2/volumes"
    private static var recentlyViewedURL = "https://www.googleapis.com/books/v1/mylibrary/bookshelves/3/volumes"
    private var cancellableSet: Set<AnyCancellable> = []
    
    // Publishers must be stored or otherwise ARC swoops by and deallocates them immediately
    @Published var isLoading: Bool = false
    private(set) var wishlistBooks: [Book] = []
    private(set) var recentlyViewedBooks: [Book] = []
    
    init(wishlistBooks: [Book] = [], recentlyViewedBooks: [Book] = []) {
        self.wishlistBooks = wishlistBooks
        self.recentlyViewedBooks = recentlyViewedBooks
    }
    
    func getBooks() {
        guard let currentUser = GIDSignIn.sharedInstance.currentUser else { return }

        isLoading = true
        currentUser.refreshTokensIfNeeded { [weak self] user, error in
            guard error == nil,
            let user = user,
            let self = self else { return }

            let accessToken = user.accessToken.tokenString
            
            Publishers.Zip(self.wishlistedPublisher(accessToken: accessToken), self.recentlyViewedPublisher(accessToken: accessToken))
                // Published changes must be done on the main thread
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { _ in
                    self.isLoading = false
                }, receiveValue: { [self] b1, b2 in
                    self.wishlistBooks = b1
                    self.recentlyViewedBooks = b2
                })
                .store(in: &self.cancellableSet)
        }
    }
    
    private func wishlistedPublisher(accessToken: String) -> AnyPublisher<[Book], Never> {
        var request =  URLRequest(url: URL(string: Self.wishlistedURL)!)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: Items.self, decoder: JSONDecoder())
            .map(\.items)
            // Print is for debugging petition contents
            .print()
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
    
    private func recentlyViewedPublisher(accessToken: String) -> AnyPublisher<[Book], Never> {
        var request =  URLRequest(url: URL(string: Self.recentlyViewedURL)!)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: Items.self, decoder: JSONDecoder())
            .map(\.items)
            // Print is for debugging petition contents
            .print()
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
