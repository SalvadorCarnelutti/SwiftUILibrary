//
//  LibraryViewModel.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 02/02/2021.
//

import Combine
import Foundation

final class LibraryViewModel: ObservableObject {
    private let _url = "https://www.googleapis.com/books/v1/volumes?q=flowers&projection=lite"
    @Published var books: [Book] {
        didSet {
            loading = false
        }
    }
    @Published var loading: Bool = true
    // Publishers must be stored or otherwise ARC swoops by and deallocates them immediately
    private var _task: AnyCancellable?
    
    init(books: [Book] = []) {
        self.books = books
    }
    
    func getBooks() {
        _task = URLSession.shared.dataTaskPublisher(for: URL(string: _url)!)
            .map { $0.data }
            .decode(type: Items.self, decoder: JSONDecoder())
//            .sink(receiveCompletion: { (error) in
//                print("Image request failed: \(String(describing: error))")
//            }, receiveValue: { value in
//
//            })
            .map(\.items)
            .replaceError(with: [])
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .assign(to: \LibraryViewModel.books, on: self)
    }
}
