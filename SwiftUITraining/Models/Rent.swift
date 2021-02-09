//
//  Rent.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 09/02/2021.
//

struct Rent: Codable, Equatable {
    var userID: Int
    var bookID: Int
    var from: String
    var to: String
}
