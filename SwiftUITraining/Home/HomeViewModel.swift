//
//  HomeViewModel.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 02/02/2021.
//

import Combine
import Foundation

final class HomeViewModel: ObservableObject {
    private let _url = "https://swift-training-backend.herokuapp.com/books"
    @Published var books: [Book] = []
    // Publishers must be stored or otherwise ARC swoops by and deallocates them immediately
    private var _task: AnyCancellable?
    
    func getBooks() {
        _task = URLSession.shared.dataTaskPublisher(for: URL(string: _url)!)
            .map { $0.data }
            .decode(type: [Book].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .assign(to: \HomeViewModel.books, on: self)
    }
}
