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
    private let _userData = UserDataSingleton.shared
    private lazy var _wishlistURL = "https://www.googleapis.com/books/v1/mylibrary/bookshelves/0/volumes"
    private var _task: AnyCancellable?
    
    // Publishers must be stored or otherwise ARC swoops by and deallocates them immediately
    @Published var loading: Bool = true
    @Published var wishlistBooks: [Book] = [] {
        didSet {
            loading = false
        }
    }
        
    init(wishlistBooks: [Book] = []) {
        self.wishlistBooks = wishlistBooks
    }
        
    func getWishlistBooks() {
        GIDSignIn.sharedInstance.currentUser!.refreshTokensIfNeeded { [self] user, error in
            guard error == nil else { return }
            guard let user = user else { return }

            // Get the access token to attach it to a REST or gRPC request.
            let accessToken = user.accessToken.tokenString
            
            var request =  URLRequest(url: URL(string: _wishlistURL)!)
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            
            _task = URLSession.shared.dataTaskPublisher(for: request)
                .map { $0.data }
                .decode(type: Items.self, decoder: JSONDecoder())
                .map(\.items)
                // Print is for debugging petition contents
                .print()
                .replaceError(with: [])
                .eraseToAnyPublisher()
                .receive(on: RunLoop.main)
                .assign(to: \WishlistViewModel.wishlistBooks, on: self)
        }
    }
}
