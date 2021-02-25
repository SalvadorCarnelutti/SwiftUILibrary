//
//  WishlistBook.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 25/02/2021.
//

struct WishlistBook: Codable, Equatable {
    var id: Int
    var user: User
    var book: Book
}
