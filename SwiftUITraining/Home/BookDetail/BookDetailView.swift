//
//  SwiftUIView.swift
//  SwiftUITraining
//
//  Created by Diego Quiros on 02/11/2020.
//

import SwiftUI

struct BookDetailView: View {
    var book: Book
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Image("img_book6")
                        .resizable()
                        .frame(width: 70, height: 105)
                        
                    VStack(alignment: .leading) {
                        Text(book.title).font(.title2)
                        Text(book.status.uppercased()).font(.headline)
                            .foregroundColor(Color(hex: 0xD0021B))
                        Text(book.author).foregroundColor(Color.charcoal)
                        Text(book.year).foregroundColor(Color.charcoal)
                        Text(book.genre).foregroundColor(Color.charcoal)
                    }
                    .padding(.leading, 20)
                    Spacer()
                }
                Button(action: {
                    // TODO: add to wishlist
                }) {
                    Text("ADD TO WISHLIST").font(.headline).foregroundColor(Color.deepSkyBlue)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .clipShape(Capsule())
                .overlay(Capsule().stroke(Color.deepSkyBlue, lineWidth: 2))
                .padding(.vertical, 12)
                Button(action: {
                    // TODO: add to wishlist
                }) {
                    Text("RENT").font(.headline).foregroundColor(Color.white)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(Color(hex: 0xDDDDDD))
                .clipShape(Capsule())
                
            }
            .padding()
            .background(Color.white.cornerRadius(5).shadow(radius: 2))
            .padding()
            Spacer()
        }
        .background(Color.lavender)
        .navigationBarTitle(Text(book.title), displayMode: .inline)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BookDetailView(book: Book.getMockBook())
        }
    }
}
