//
//  File.swift
//  SwiftUITraining
//
//  Created by Diego Quiros on 02/11/2020.
//

extension Book {
    static func getMockedBook() -> Book {
        return Book(id: 123, author: "Diego Quiros",
                    title: "The Lord of the Rings",
                    genre: "High Fantasy",
                    year: "1954",
                    image: "http://wolox-training.s3.amazonaws.com/uploads/41DNuJfahyL._SX322_BO1_204_203_200_.jpg",
                    status: "Available")
    }
    
    static func getMockedBooks() -> [Book] {
        var mockedBooks: [Book] = []
        
        for _ in 0...8 {
            mockedBooks.append(getMockedBook())
        }
        
        return mockedBooks
    }
}
