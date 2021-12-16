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
