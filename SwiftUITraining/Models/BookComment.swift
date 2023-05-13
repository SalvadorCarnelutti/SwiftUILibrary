//
//  BookComment.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 13/02/2021.
//

struct BookComment: Codable, Equatable, Identifiable {
    var id: Int
    var username: String
    var content: String
}
