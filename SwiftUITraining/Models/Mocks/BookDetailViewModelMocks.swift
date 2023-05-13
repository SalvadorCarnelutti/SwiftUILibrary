//
//  BookDetailViewModelMocks.swift
//  SwiftUITraining
//
//  Created by Salvador on 5/12/23.
//

import Foundation

extension BookDetailViewModel {
    static func getMockedViewModel(wishlistable: Bool) -> BookDetailViewModel {
        let mockedViewModel = BookDetailViewModel(book: Book.getMockedBook(), wishlistable: wishlistable)
        mockedViewModel.bookComments = BookComment.getMockedBookComments()
        return mockedViewModel
    }
}
