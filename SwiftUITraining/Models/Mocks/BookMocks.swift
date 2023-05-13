//
//  File.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 02/11/2020.
//

extension Book {
    private static let mockThumbnailUrl = "https://books.google.com/books/publisher/content?id=nVQPAAAAQBAJ&printsec=frontcover&img=1&zoom=1&imgtk=AFLRE73iRHWnQxXfaklTbkp7SjbauKWZXDDG-6wl3z6zpkRM5Bx1QntZoDjpmvt7lT1gvGeMLENq-KEhOOaYwZg4Ab46yvIhIgQbkAwLlw8glDQ5v4ZZD60R0bi6FS4CGnDV5s4kVZlL"
    
    static func getMockedBook(id: Int = 1) -> Book {
        Book(id: String(id),
             volumeInfo: VolumeInfo(title: "The Design of Everyday Things",
                                    publishedDate: "2013",
                                    pageCount: 384,
                                    imageLinks: ImageLinks(thumbnail: Self.mockThumbnailUrl)))
    }
    
    static func getMockedBooks(count: Int = 9) -> [Book] {
        var mockedBooks: [Book] = []
        
        for i in 1...count {
            mockedBooks.append(getMockedBook(id: i))
        }
        
        return mockedBooks
    }
    
    static func getMockedWishlistBook(id: Int = 1) -> Book {
        Book(id: String(id),
             volumeInfo: VolumeInfo(title: "The Design of Everyday Things",
                                    publishedDate: "2013",
                                    pageCount: 384,
                                    imageLinks: ImageLinks(thumbnail: Self.mockThumbnailUrl)))
    }
    
    static func getMockedWishlistBooks(count: Int = 2) -> [Book] {
        var mockedWishlistBooks: [Book] = []
        
        for i in 1...count {
            mockedWishlistBooks.append(getMockedWishlistBook(id: i))
        }
        
        return mockedWishlistBooks
    }
}
