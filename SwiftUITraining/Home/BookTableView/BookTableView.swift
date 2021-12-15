//
//  BookTableView.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 25/02/2021.
//

import SwiftUI

struct BookTableView: View {
    let books: [Book]
    
    var body: some View {
        ScrollView {
            LazyVStack {
                Color.clear.padding(.bottom, 20)
                /* I need to do this because currently, the wishlist button lets the user wish for a book more than once
                 and then there is no longer unique IDs...
                 If not, it could simply be:
                 ForEach(books) { book in
                 */
                ForEach(0..<books.count, id: \.self) { index in
                    BookCellView(book: books[index])
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
        BookTableView(books: mockedBooks)
    }
}
