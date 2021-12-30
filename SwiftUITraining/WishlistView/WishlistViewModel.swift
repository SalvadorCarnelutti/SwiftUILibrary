//
//  WishlistViewModel.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 25/02/2021.
//

import Combine
import Foundation

class WishlistViewModel: ObservableObject {
    private let _userData = UserDataSingleton.shared
//    private lazy var _wishlistURL = "https://...\(_userData.id)"
    private lazy var _wishlistURL = "https://myjson.dit.upm.es/api/bins/bg4p"
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
        _task = URLSession.shared.dataTaskPublisher(for: URL(string: _wishlistURL)!)
            .map { $0.data }
            .decode(type: [Book].self, decoder: JSONDecoder())
            // Print is for debugging petition contents
            .print()
            .replaceError(with: [])
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .assign(to: \WishlistViewModel.wishlistBooks, on: self)
    }
}
