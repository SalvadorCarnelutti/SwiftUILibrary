//
//  BookCommentMocks.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 13/02/2021.
//

extension BookComment {
    static func getMockedBookComments(count: Int = 7) -> [BookComment] {
        var mockedComments: [BookComment] = []
        
        for i in 1...count {
            mockedComments.append(BookComment(id: i,
                                              username: "John Doe",
                                              content: "I recommend this book! It's really interesting."))
        }
        
        return mockedComments
    }
}
