//
//  BookCellView.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 16/10/2020.
//

import SwiftUI

struct BookCellView: View {
    let book: Book
    let wishlistable: Bool
    
    var body: some View {
        let bookDetailViewModel = BookDetailViewModel(book: book, wishlistable: wishlistable)
        
        NavigationLink(destination: BookDetailView(bookDetailViewModel: bookDetailViewModel)) {
            HStack(alignment: .top) {
                RemoteImage(url: book.image)
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 80)
                    .padding(.trailing, 20)
                    .padding(.leading, 30)
                    .shadow(radius: 3.0)
                
                VStack(alignment: .leading) {
                    Text(book.title).font(.system(size: 17, weight: .bold, design: .default))
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(nil)
                        .foregroundColor(Color.charcoal)
                    Text(book.author).font(.system(size: 15, weight: .light, design: .default))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.charcoal)
                }
                Spacer()
            }
            .padding(.vertical, 15)
            .padding(.trailing, 20)
            .cornerRadius(10)
            .background(Color.white.cornerRadius(5).shadow(radius: 2))
        }
    }
}

struct BookCellView_Previews: PreviewProvider {
    static var previews: some View {
        BookCellView(book: Book.getMockedBook(), wishlistable: true)
            .padding()
    }
}
