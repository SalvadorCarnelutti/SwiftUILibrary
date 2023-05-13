//
//  BookDetailAboutView.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 16/03/2021.
//

import SwiftUI

struct BookDetailAboutView: View {
    let book: Book
    
    var body: some View {
        HStack(alignment: .top) {
            RemoteImage(url: book.image)
                .frame(width: 70, height: 105)
                .shadow(radius: 3.0)
            
            VStack(alignment: .leading) {
                Text(book.title)
                    .font(.title2)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(nil)

                Text(book.author)
                    .foregroundColor(Color.charcoal)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(nil)
                Text(book.year)
                    .foregroundColor(Color.charcoal)
                Text(book.pageCount)
                    .foregroundColor(Color.charcoal)
            }
            .padding(.leading, 20)
            Spacer()
        }
    }
}

struct BookDetailAboutView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailAboutView(book: Book.getMockedBook())
        .padding()
    }
}
