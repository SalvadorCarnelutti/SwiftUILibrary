//
//  BookTableView.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 25/02/2021.
//

import SwiftUI

struct BookTableView: View {
    let books: [Book]
    let wishlistable: Bool
    
    var body: some View {
        ScrollView {
            LazyVStack {
                Color.clear.padding(.bottom, 20)
                ForEach(books) { book in
                    BookCellView(book: book, wishlistable: wishlistable)
                        .padding(.bottom, 5)
                }
                Color.clear.padding(.bottom, 10)
            }
            .padding(.horizontal, 20)
        }
    }
}

struct BookTableView_Previews: PreviewProvider {
    static var previews: some View {
        let mockedBooks = Book.getMockedBooks()
        BookTableView(books: mockedBooks, wishlistable: true)
    }
}
