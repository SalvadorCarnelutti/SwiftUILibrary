//
//  BookDetailViewModel.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 09/02/2021.
//

import Combine
import Foundation
import GoogleSignIn

class BookDetailViewModel: ObservableObject {
    private let _userData = UserDataSingleton.shared
    private lazy var _rentURL = "https://...\(_userData.id)"
    private lazy var _wishURL = "https://www.googleapis.com/books/v1/mylibrary/bookshelves/2/addVolume"
//    private lazy var _commentsURL = "https://...\(_book.id)"
    private lazy var _commentsURL = "https://myjson.dit.upm.es/api/bins/hgy9"
    private var _lastBookComment: BookComment?
    private var _thirdBookComment: BookComment?
    private var _task: AnyCancellable?

    
    // Publishers must be stored or otherwise ARC swoops by and deallocates them immediately
    @Published private var _book: Book
    @Published private(set) var bookComments: [BookComment] = [] {
        didSet {
            _lastBookComment = bookComments.last
            _thirdBookComment = Array(bookComments.prefix(3)).last
            commentsFullyShown = bookComments.count <= 3
            loading = false
        }
    }
    @Published var loading: Bool = false
    @Published var commentsFullyShown: Bool = false

    init(book: Book) {
        self._book = book
    }
   
    func postBookRent() {
//        guard let httpBody = getEncodedRentBody else { return }
//        var request =  URLRequest(url: URL(string: _rentURL)!)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        request.httpBody = httpBody
//
//        let session = URLSession.shared
//        loading = true
//        let task = session.dataTask(with: request) { [weak self] data, response, error in
//            DispatchQueue.main.async { [weak self] in
//                self?.loading = false
//            }
//
//            if response != nil {
//                // Publishing changes from background threads is not allowed; make sure to publish values from the main thread
//                DispatchQueue.main.async { [weak self] in
//                    self?._book.setAsUnavailable()
//                    self?.loading = false
//                }
//                print("Successful")
//            } else {
//                print("Unsuccessful")
//            }
//        }
//        task.resume()
    }
    
    func postBookWish() {
        GIDSignIn.sharedInstance.currentUser!.refreshTokensIfNeeded { user, error in
            guard error == nil else { return }
            guard let user = user else { return }

            // Get the access token to attach it to a REST or gRPC request.
            let accessToken = user.accessToken.tokenString
            
            var url = URLComponents(string: self._wishURL)!
            url.queryItems = [URLQueryItem(name: "volumeId", value: self._book.id)]
            var request = URLRequest(url: url.url!)
            request.httpMethod = "POST"
            
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            
            self._task = URLSession.shared.dataTaskPublisher(for: request)
                .map(\.data)
                .compactMap { String(data: $0, encoding:. utf8) }
                .sink(receiveCompletion: { (error) in
                    print("Image request failed: \(String(describing: error))")
                }, receiveValue: { value in
                    print(value == "204 No Content")
                })
        }
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
//        return _book.status
        ""
    }
    
    var getBookAuthor: String {
        return _book.author
    }
    
    var getBookYear: String {
//        return _book.year
        ""
    }
    
    var getBookGenre: String {
//        return _book.genre
        ""
    }
    
    var getBookURL: String {
        return _book.image
    }
    
    var displayedBookComments: [BookComment] {
        return commentsFullyShown ? bookComments : Array(bookComments.prefix(3))
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

    func commentHasDivider(_ bookComment: BookComment) -> Bool {
        return (commentsFullyShown && !isLastBookComment(bookComment)) || !commentsFullyShown
    }
    
    func canDisplayMore(_ bookComment: BookComment) -> Bool {
        return isThirdBookComment(bookComment) && !commentsFullyShown
    }
        
//    static func getMockedViewModel() -> BookDetailViewModel {
//        let mockedViewModel = BookDetailViewModel(book: Book.getMockedBook())
//        mockedViewModel.bookComments = BookComment.getMockedBookComments()
//        return mockedViewModel
//    }
}

private extension BookDetailViewModel {
    func isLastBookComment(_ bookComment: BookComment) -> Bool {
        return bookComment == _lastBookComment
    }
    
    func isThirdBookComment(_ bookComment: BookComment) -> Bool {
        return bookComment == _thirdBookComment
    }
}
