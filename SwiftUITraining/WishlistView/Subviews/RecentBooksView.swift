//
//  RecentBooksView.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 01/03/2021.
//

import SwiftUI

struct RecentBooksView: View {
    let books: [Book]
    
    var body: some View {
        if books.isNotEmpty {
            ZStack(alignment: .topLeading) {
                HStack {
                    Text("Recently viewed").font(.headline)
                    Spacer()
                }
                .padding(.leading)
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        ForEach(books) { book in
                            RemoteImage(url: book.image)
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 65)
                                .shadow(radius: 3.0)
                        }
                    }
                    .padding(EdgeInsets(top: 30, leading: 20, bottom: 10, trailing: 20))
                }.frame(height: 120)
            }
            .background(Color.white.shadow(radius: 2))
        }
    }
}

struct RecentBooksView_Previews: PreviewProvider {
    static var previews: some View {
        let mockedBooks = Book.getMockedWishlistBooks()
        
        RecentBooksView(books: mockedBooks)
    }
}
