//
//  BookCommentMocks.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 13/02/2021.
//

extension BookComment {
    static func getMockedBookComments() -> [BookComment] {
        var mockedComments: [BookComment] = []
        let mockedUser = User(id: 1,
                              username: "juanrodriguez",
                              image: "img_user1")
        for _ in 0...2 {
            mockedComments.append(BookComment(id: 1,
                                              user: mockedUser,
                                              book: Book.getMockedBook(),
                                              content: "I recommend this book! It's really interesting."))
        }
        
        return mockedComments
    }
}
