//
//  BookDetailAbout.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 16/03/2021.
//

import SwiftUI

struct BookDetailAbout: View {
    @ObservedObject var bookDetailViewModel: BookDetailViewModel
    let addAction: () -> ()
    let rentAction: () -> ()
    static func mockVoidFunction() -> () {}
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                RemoteImage(url: bookDetailViewModel.getBookURL)
                    .frame(width: 70, height: 105)
                
                VStack(alignment: .leading) {
                    Text(bookDetailViewModel.getBookTitle)
                        .font(.title2)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(nil)
                    Text(bookDetailViewModel.getBookStatus.uppercased())
                        .font(.headline)
                        .foregroundColor(statusColor)
                    Text(bookDetailViewModel.getBookAuthor)
                        .foregroundColor(Color.charcoal)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(nil)
                    Text(bookDetailViewModel.getBookYear)
                        .foregroundColor(Color.charcoal)
                    Text(bookDetailViewModel.getBookGenre)
                        .foregroundColor(Color.charcoal)
                }
                .padding(.leading, 20)
                Spacer()
            }
            Button(action: {
                addAction()
            }) {
                Text("ADD TO WISHLIST").font(.headline).foregroundColor(Color.deepSkyBlue)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.deepSkyBlue, lineWidth: 2))
            .padding(.vertical, 12)
            Button(action: {
                rentAction()
            }) {
                Text("RENT").font(.headline).foregroundColor(Color.white)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(rentButtonColor)
            .clipShape(Capsule())
        }
    }
    
    var statusColor: Color {
        return bookDetailViewModel.bookIsAvailable ? Color.atlantis : Color.venetianRed
    }
    
    var rentButtonColor: LinearGradient {
        let availableGradient = LinearGradient(gradient: Gradient(colors: [Color.deepSkyBlue, Color.mediumTurquoise]),
                                               startPoint: .leading, endPoint: .trailing)
        let unavailableGradient = LinearGradient(gradient: Gradient(colors: [Color.gainsboro]),
                                                 startPoint: .leading, endPoint: .trailing)
        return bookDetailViewModel.bookIsAvailable ? availableGradient : unavailableGradient
    }
}

struct BookDetailAbout_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailAbout(bookDetailViewModel: BookDetailViewModel(book: Book.getMockedBook()),
                        addAction: BookDetailAbout.mockVoidFunction,
                        rentAction: BookDetailAbout.mockVoidFunction)
    }
}
