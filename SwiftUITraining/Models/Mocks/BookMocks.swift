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
//        return Book(id: "1",
//                    author: "Don Norman",
//                    title: "The Design of Everyday Things",
//                    genre: "Thesis",
//                    year: "1998",
//                    image: "https://images-na.ssl-images-amazon.com/images/I/410RTQezHYL._SX326_BO1,204,203,200_.jpg",
//                    status: "Available")
    }
//    
    static func getMockedBooks() -> [Book] {
        var mockedBooks: [Book] = []
        
        for i in 1...9 {
            mockedBooks.append(getMockedBook(id: i))
        }
        
        return mockedBooks
    }
//    
    static func getMockedWishlistBook(id: Int = 1) -> Book {
//        return Book(id: "2",
//                    author: "Garcia Marquez",
//                    title: "100 Años de soledad",
//                    genre: "Magical Realism",
//                    year: "1967",
//                    image: "https://images-na.ssl-images-amazon.com/images/I/51egIZUl88L._SX336_BO1,204,203,200_.jpg",
//                    status: "Unavailable")
        Book(id: String(id),
             volumeInfo: VolumeInfo(title: "The Design of Everyday Things",
                                    publishedDate: "2013",
                                    pageCount: 384,
                                    imageLinks: ImageLinks(thumbnail: Self.mockThumbnailUrl)))
    }
    
    static func getMockedWishlistBooks() -> [Book] {
        var mockedWishlistBooks: [Book] = []
        
        for i in 1...2 {
            mockedWishlistBooks.append(getMockedWishlistBook(id: i))
        }
        
        return mockedWishlistBooks
    }
}
