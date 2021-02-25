//
//  WishlistBookMocks.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 25/02/2021.
//

extension WishlistBook {
    static func getMockedBookComments() -> [WishlistBook] {
        var mockedComments: [WishlistBook] = []
        let mockedUser = User(id: 1,
                              username: "juanrodriguez",
                              image: "img_user1")
        for _ in 0...2 {
            mockedComments.append(WishlistBook(id: 1,
                                               user: mockedUser,
                                               book: Book.getMockedBook()))
        }
        
        return mockedComments
    }
}
