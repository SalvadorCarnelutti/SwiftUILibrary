//
//  File.swift
//  SwiftUITraining
//
//  Created by Diego Quiros on 02/11/2020.
//

extension Book {
    static func getMockedBook() -> Book {
        return Book(id: 1,
                    author: "Don Norman",
                    title: "The Design of Everyday Things",
                    genre: "Thesis",
                    year: "1998",
                    image: "https://images-na.ssl-images-amazon.com/images/I/410RTQezHYL._SX326_BO1,204,203,200_.jpg",
                    status: "Available")
    }
    
    static func getMockedBooks() -> [Book] {
        var mockedBooks: [Book] = []
        
        for _ in 1...9 {
            mockedBooks.append(getMockedBook())
        }
        
        return mockedBooks
    }
    
    static func getMockedWishlistBook() -> Book {
        return Book(id: 2,
                    author: "Garcia Marquez",
                    title: "100 Años de soledad",
                    genre: "Magical Realism",
                    year: "1967",
                    image: "https://images-na.ssl-images-amazon.com/images/I/51egIZUl88L._SX336_BO1,204,203,200_.jpg",
                    status: "Unavailable")
    }
    
    static func getMockedWishlistBooks() -> [Book] {
        var mockedWishlistBooks: [Book] = []
        
        for _ in 1...2 {
            mockedWishlistBooks.append(getMockedWishlistBook())
        }
        
        return mockedWishlistBooks
    }
}
