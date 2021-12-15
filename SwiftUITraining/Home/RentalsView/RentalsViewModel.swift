//
//  RentalsViewModel.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 01/03/2021.
//

import Combine
import Foundation

class RentalsViewModel: ObservableObject {
    private let _userData = UserDataSingleton.shared
    private lazy var _rentalsURL = "https://swift-training-backend.herokuapp.com/users/\(_userData.id)/rents"
    
    @Published var rentalBooks: [WishlistBook] = []
    // Publishers must be stored or otherwise ARC swoops by and deallocates them immediately
    private var _task: AnyCancellable?
        
    func getRentalBooks() {
//        _task = URLSession.shared.dataTaskPublisher(for: URL(string: _rentalsURL)!)
//            .map { $0.data }
//            .decode(type: [WishlistBook].self, decoder: JSONDecoder())
//            // Print is for debugging petition contents
//            .print()
//            .replaceError(with: [])
//            .eraseToAnyPublisher()
//            .receive(on: RunLoop.main)
//            .assign(to: \RentalsViewModel.rentalBooks, on: self)
    }
}
