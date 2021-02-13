//
//  BookDetailViewModel.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 09/02/2021.
//

import Combine
import Foundation

class BookDetailViewModel: ObservableObject {
    private let _userData = UserDataSingleton.shared
    private lazy var _rentURL = "https://swift-training-backend.herokuapp.com/users/\(_userData.id)/rents"
    private lazy var _commentsURL = "https://swift-training-backend.herokuapp.com/books/\(_book.id)/comments"
    
    @Published private var _book: Book
    @Published private(set) var bookComments: [BookComment] = [] {
        didSet {
            _lastBookComment = bookComments.suffix(5).last
        }
    }
    private var _lastBookComment: BookComment?
    private var _task: AnyCancellable?

    init(book: Book) {
        self._book = book
    }
   
    func rentBook() {
        guard let httpBody = getEncodedRentBody else { return }
        var request =  URLRequest(url: URL(string: _rentURL)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = httpBody
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if response != nil {
                DispatchQueue.main.async { [weak self] in
                    self?._book.setAsUnavailable()
                }
                print("Finally, some fucking good food")
            } else {
                print("You messed something up, you fucking donkey")
            }
        }
        task.resume()
    }
    
    private var getEncodedRentBody: Data? {
        let today = Date()
        let yearMonthDayFormat = DateFormatter()
        yearMonthDayFormat.dateFormat = "yyyy-MM-dd"
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)
        
        let encoder = JSONEncoder()
        let rentModel = Rent(userID: _userData.id,
                             bookID: _book.id,
                             from: yearMonthDayFormat.string(from: today),
                             to: yearMonthDayFormat.string(from: tomorrow!))
        
        guard let encoded = try? encoder.encode(rentModel) else {
            return nil
        }
        
        return encoded
    }
    
    var bookIsAvailable: Bool {
        return getBookStatus.lowercased() == "available"
    }
    
    var getBookTitle: String {
        return _book.title
    }
    
    var getBookStatus: String {
        return _book.status
    }
    
    var getBookAuthor: String {
        return _book.author
    }
    
    var getBookYear: String {
        return _book.year
    }
    
    var getBookGenre: String {
        return _book.genre
    }
        
    func getBookComments() {
        _task = URLSession.shared.dataTaskPublisher(for: URL(string: _commentsURL)!)
            .map { $0.data }
            .decode(type: [BookComment].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .assign(to: \BookDetailViewModel.bookComments, on: self)
    }
    
    func isLastBookComment(_ bookComment: BookComment) -> Bool {
        return bookComment == _lastBookComment
    }
        
    static func getMockedViewModel() -> BookDetailViewModel {
        let mockedViewModel = BookDetailViewModel(book: Book.getMockedBook())
        mockedViewModel.bookComments = BookComment.getMockedBookComment()
        return mockedViewModel
    }
}
