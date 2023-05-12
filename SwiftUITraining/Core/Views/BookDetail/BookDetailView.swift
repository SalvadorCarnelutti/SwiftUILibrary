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
    @State var didAppear = false
    
    var body: some View {
        LoadingView(isShowing: $bookDetailViewModel.loading) {
            VStack {
                BookDetailAbout(bookDetailViewModel: bookDetailViewModel,
                                addAction: addAction)
                .padding()
                .background(Color.white.cornerRadius(5).shadow(radius: 2))
                .padding()
                BookDetailComments(bookDetailViewModel: bookDetailViewModel)
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
        .listStyle(GroupedListStyle())
        .onAppear {
            if !didAppear {
                bookDetailViewModel.getBookComments()
                didAppear = true
            }
        }
    }
    
    func addAction() {
        bookDetailViewModel.postBookWish()
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BookDetailView(bookDetailViewModel: BookDetailViewModel.getMockedViewModel())
        }
    }
}
