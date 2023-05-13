//
//  SwiftUIView.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 02/11/2020.
//

import SwiftUI

struct BookDetailView: View {
    @State private var unavailableIsPresented = false
    @StateObject var bookDetailViewModel: BookDetailViewModel
        
    var body: some View {
        LoadingView(isShowing: $bookDetailViewModel.loading) {
            VStack {
                VStack {
                    BookDetailAboutView(book: bookDetailViewModel.book)
                    
                    if bookDetailViewModel.wishlistable {
                        Button(action: { addAction() }) {
                            Text("ADD TO WISHLIST").font(.headline).foregroundColor(Color.deepSkyBlue)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(Color.deepSkyBlue, lineWidth: 2))
                        .padding(.vertical, 12)
                    }
                }
                .padding()
                .background(Color.white.cornerRadius(5).shadow(radius: 2))
                .padding()
                
                BookDetailCommentsView(bookDetailViewModel: bookDetailViewModel)
                    .padding(.bottom, 10)
            }
        }
        .background(Color.lavender)
        .navigationBarTitle(Text(bookDetailViewModel.getBookTitle), displayMode: .inline)
        .alert(isPresented: $unavailableIsPresented, content: {
            Alert(title: Text("Sorry, this current book is unavailable at the moment"),
                  message: Text("Try again later"),
                  dismissButton: .default(Text("Ok")))
        })
        .onAppear {
            bookDetailViewModel.getBookComments()
        }
    }
    
    func addAction() {
        bookDetailViewModel.postBookWish()
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BookDetailView(bookDetailViewModel: BookDetailViewModel.getMockedViewModel(wishlistable: true))
        }
    }
}
