//
//  BookCommentMocks.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 13/02/2021.
//

extension BookComment {
    static func getMockedBookComment(id: Int = 1) -> BookComment {
        BookComment(id: id,
                    username: "John Doe",
                    content: "I recommend this book! It's really interesting.")
    }
    
    static func getMockedBookComments(count: Int = 7) -> [BookComment] {
        (1...count).map { getMockedBookComment(id: $0) }
    }
}
