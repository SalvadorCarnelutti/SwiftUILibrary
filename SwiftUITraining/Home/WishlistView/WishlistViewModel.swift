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
    private lazy var _wishlistURL = "https://swift-training-backend.herokuapp.com/users/\(_userData.id)/wishes"
    
    @Published var wishlistBooks: [WishlistBook] = []
    // Publishers must be stored or otherwise ARC swoops by and deallocates them immediately
    private var _task: AnyCancellable?
        
    func getWishlistBooks() {
//        _task = URLSession.shared.dataTaskPublisher(for: URL(string: _wishlistURL)!)
//            .map { $0.data }
//            .decode(type: [WishlistBook].self, decoder: JSONDecoder())
//            // Print is for debugging petition contents
//            .print()
//            .replaceError(with: [])
//            .eraseToAnyPublisher()
//            .receive(on: RunLoop.main)
//            .assign(to: \WishlistViewModel.wishlistBooks, on: self)
    }
}
