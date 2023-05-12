//
//  BookCommentMocks.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 13/02/2021.
//

extension BookComment {
    static func getMockedBookComments() -> [BookComment] {
        var mockedComments: [BookComment] = []
        
        for i in 1...7 {
            mockedComments.append(BookComment(id: i,
                                              username: "John Doe",
                                              content: "I recommend this book! It's really interesting."))
        }
        
        return mockedComments
    }
}
