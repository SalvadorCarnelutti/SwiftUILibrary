//
//  BookCommentMocks.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 13/02/2021.
//

extension BookComment {
    static func getMockedBookComments() -> [BookComment] {
        var mockedComments: [BookComment] = []
//        let mockedUser = User(id: 1,
//                              username: "juanrodriguez",
//                              image: "person.crop.circle")
        for _ in 1...4 {
            mockedComments.append(BookComment(id: 1,
                                              username: "John Doe",
//                                              user: mockedUser,
//                                              book: Book.getMockedBook(),
                                              content: "I recommend this book! It's really interesting."))
        }
        
        return mockedComments
    }
}
