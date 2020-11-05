//
//  BookCellView.swift
//  SwiftUITraining
//
//  Created by Diego Quiros on 16/10/2020.
//

import SwiftUI

struct BookCellView: View {
    var book: Book
    
    var body: some View {
        NavigationLink(destination: BookDetailView(book: book)) {
            HStack(alignment: .top) {
                Image("img_book6")
                    .padding(.trailing, 20)
                    .padding(.leading, 30)
                
                VStack(alignment: .leading) {
                    Text(book.title).font(.system(size: 17, weight: .bold, design: .default)).foregroundColor(Color(hex: 0x4A4A4A))
                    Text(book.author).font(.system(size: 15, weight: .light, design: .default)).foregroundColor(Color(hex: 0x4A4A4A))
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
        BookCellView(book: Book.getMockBook())
    }
}
