//
//  SwiftUIView.swift
//  SwiftUITraining
//
//  Created by Diego Quiros on 02/11/2020.
//

import SwiftUI

struct BookDetailView: View {
    @State private var unavailableIsPresented = false
    @StateObject var bookDetailViewModel: BookDetailViewModel
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Image("img_book6")
                        .resizable()
                        .frame(width: 70, height: 105)
                        
                    VStack(alignment: .leading) {
                        Text(bookDetailViewModel.getBookTitle).font(.title2)
                        Text(bookDetailViewModel.getBookStatus.uppercased()).font(.headline)
                            .foregroundColor(statusColor)
                        Text(bookDetailViewModel.getBookAuthor).foregroundColor(Color.charcoal)
                        Text(bookDetailViewModel.getBookYear).foregroundColor(Color.charcoal)
                        Text(bookDetailViewModel.getBookGenre).foregroundColor(Color.charcoal)
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
                    if bookDetailViewModel.bookIsAvailable {
                        bookDetailViewModel.rentBook()
                    } else {
                        unavailableIsPresented.toggle()
                    }
                }) {
                    Text("RENT").font(.headline).foregroundColor(Color.white)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(Color.gainsboro)
                .clipShape(Capsule())
                
            }
            .padding()
            .background(Color.white.cornerRadius(5).shadow(radius: 2))
            .padding()
            Spacer()
        }
        .background(Color.lavender)
        .navigationBarTitle(Text(bookDetailViewModel.getBookTitle), displayMode: .inline)
        .edgesIgnoringSafeArea(.bottom)
        .alert(isPresented: $unavailableIsPresented, content: {
            Alert(title: Text("Sorry, this curent book is unavailable at the moment"),
                  message: Text("Try again later"),
                  dismissButton: .default(Text("Ok")))
        })
    }
    
    var statusColor: Color {
        return bookDetailViewModel.bookIsAvailable ? Color.atlantis : Color.venetianRed
    }
    
    /*
     // TO DO: Add when gradient color is done
     var rentButtonColor: Color {
         return bookDetailViewModel.bookIsAvailable ? GRADIENT : Color.gainsboro
     }
     */
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BookDetailView(bookDetailViewModel: BookDetailViewModel(book: Book.getMockedBook()))
        }
    }
}
