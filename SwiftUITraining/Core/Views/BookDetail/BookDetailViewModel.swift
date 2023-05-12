//
//  BookDetailViewModel.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 09/02/2021.
//

import Combine
import GoogleSignIn

class BookDetailViewModel: ObservableObject {
    private static let wishURL = "https://www.googleapis.com/books/v1/mylibrary/bookshelves/2/addVolume"
    private static let viewedURL = "https://www.googleapis.com/books/v1/mylibrary/bookshelves/3/addVolume"
    private var lastBookComment: BookComment?
    private var thirdBookComment: BookComment?
    private var tasks: Set<AnyCancellable> = []

    // Publishers must be stored or otherwise ARC swoops by and deallocates them immediately
    @Published private var book: Book
    @Published private(set) var bookComments: [BookComment] = [] {
        didSet {
            lastBookComment = bookComments.last
            thirdBookComment = Array(bookComments.prefix(3)).last
            commentsFullyShown = bookComments.count <= 3
            loading = false
        }
    }
    @Published var loading: Bool = false
    @Published var commentsFullyShown: Bool = false

    init(book: Book) {
        self.book = book
        postBookViewed()
    }
    
    func postBookWish() {
        guard let currentUser = GIDSignIn.sharedInstance.currentUser else { return }
        
        currentUser.refreshTokensIfNeeded { [weak self] user, error in
            guard error == nil,
            let user = user,
            let self = self else { return }

            // Get the access token to attach it to a REST or gRPC request.
            let accessToken = user.accessToken.tokenString
            
            var urlComponets = URLComponents(string: Self.wishURL)!
            urlComponets.queryItems = [URLQueryItem(name: "volumeId", value: self.book.id)]
            var request = URLRequest(url: urlComponets.url!)
            request.httpMethod = "POST"
            
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTaskPublisher(for: request)
                .map(\.data)
                // Print is for debugging petition contents
                .print()
                .compactMap { String(data: $0, encoding:. utf8) }
                .sink(receiveCompletion: { error in },
                      receiveValue: { value in })
                .store(in: &self.tasks)
        }
    }
    
    func postBookViewed() {
        guard let currentUser = GIDSignIn.sharedInstance.currentUser else { return }
        
        currentUser.refreshTokensIfNeeded { [weak self] user, error in
            guard error == nil,
            let user = user,
            let self = self else { return }

            // Get the access token to attach it to a REST or gRPC request.
            let accessToken = user.accessToken.tokenString
            
            var urlComponents = URLComponents(string: Self.viewedURL)!
            urlComponents.queryItems = [URLQueryItem(name: "volumeId", value: self.book.id)]
            var request = URLRequest(url: urlComponents.url!)
            request.httpMethod = "POST"
            
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTaskPublisher(for: request)
                .map(\.data)
                // Print is for debugging petition contents
                .print()
                .compactMap { String(data: $0, encoding:. utf8) }
                .sink(receiveCompletion: { error in },
                      receiveValue: { value in })
                .store(in: &self.tasks)
        }
    }
    
    var getBookTitle: String {
        book.title
    }
    
    var getBookAuthor: String {
        book.author
    }
    
    var getBookYear: String {
        book.year
    }
    
    var getBookPageCount: String {
        book.pageCount
    }
    
    var getBookURL: String {
        book.image
    }
    
    var displayedBookComments: [BookComment] {
        commentsFullyShown ? bookComments : Array(bookComments.prefix(3))
    }
        
//    func getBookComments() {
//        URLSession.shared.dataTaskPublisher(for: URL(string: Self.commentsURL)!)
//            .map { $0.data }
//            .decode(type: [BookComment].self, decoder: JSONDecoder())
//            .replaceError(with: [])
//            .eraseToAnyPublisher()
//            .receive(on: RunLoop.main)
//            .assign(to: \BookDetailViewModel.bookComments, on: self)
//            .store(in: &tasks)
//    }

    func commentHasDivider(_ bookComment: BookComment) -> Bool {
        (commentsFullyShown && !isLastBookComment(bookComment)) || !commentsFullyShown
    }
    
    func canDisplayMore(_ bookComment: BookComment) -> Bool {
        isThirdBookComment(bookComment) && !commentsFullyShown
    }
        
    static func getMockedViewModel() -> BookDetailViewModel {
        let mockedViewModel = BookDetailViewModel(book: Book.getMockedBook())
        mockedViewModel.bookComments = BookComment.getMockedBookComments()
        return mockedViewModel
    }
}

private extension BookDetailViewModel {
    func isLastBookComment(_ bookComment: BookComment) -> Bool {
        return bookComment == lastBookComment
    }
    
    func isThirdBookComment(_ bookComment: BookComment) -> Bool {
        return bookComment == thirdBookComment
    }
}
