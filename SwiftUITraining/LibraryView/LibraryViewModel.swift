//
//  LibraryViewModel.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 02/02/2021.
//

import Combine
import Foundation

final class LibraryViewModel: ObservableObject {
    private static let url = "https://www.googleapis.com/books/v1/volumes?q=flowers&By=newest"
    @Published var books: [Book] {
        didSet {
            isLoading = false
        }
    }
    @Published var isLoading: Bool = true
    // Publishers must be stored or otherwise ARC swoops by and deallocates them immediately
    private var cancellableSet: Set<AnyCancellable> = []
    
    init(books: [Book] = []) {
        self.books = books
    }
    
    func getBooks() {
        URLSession.shared.dataTaskPublisher(for: URL(string: Self.url)!)
            .map { $0.data }
            .decode(type: Items.self, decoder: JSONDecoder())
            .print()
            .map(\.items)
            .replaceError(with: [])
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .assign(to: \LibraryViewModel.books, on: self)
            .store(in: &cancellableSet)
    }
}
