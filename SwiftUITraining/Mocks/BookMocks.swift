//
//  File.swift
//  SwiftUITraining
//
//  Created by Diego Quiros on 02/11/2020.
//

extension Book {
    static func getMockedBook() -> Book {
        return Book(id: 123, author: "Diego", title: "El señor de los anillos", genre: "misterio", year: "1999", image: "", status: "Available")
    }
    
    static func getMockedBooks() -> [Book] {
        var mockedBooks: [Book] = []
        
        for _ in 0...8 {
            mockedBooks.append(getMockedBook())
        }
        
        return mockedBooks
    }
}
