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
        LoadingView(isShowing: $bookDetailViewModel.loading) {
            VStack {
                BookDetailAbout(bookDetailViewModel: bookDetailViewModel,
                                addAction: addAction,
                                rentAction: rentAction)
                .padding()
                .background(Color.white.cornerRadius(5).shadow(radius: 2))
                .padding()
                BookDetailComments(bookDetailViewModel: bookDetailViewModel)
            }
        }
        .background(Color.lavender)
        .navigationBarTitle(Text(bookDetailViewModel.getBookTitle), displayMode: .inline)
        .edgesIgnoringSafeArea(.bottom)
        .alert(isPresented: $unavailableIsPresented, content: {
            Alert(title: Text("Sorry, this curent book is unavailable at the moment"),
                  message: Text("Try again later"),
                  dismissButton: .default(Text("Ok")))
        })
        .listStyle(GroupedListStyle())
        .onAppear {
//            bookDetailViewModel.loading = true
            bookDetailViewModel.getBookComments()
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
    
    func addAction() {
        bookDetailViewModel.postBookWish()
    }
    
    func rentAction() {
        bookDetailViewModel.bookIsAvailable ?
            bookDetailViewModel.postBookRent() : unavailableIsPresented.toggle()
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BookDetailView(bookDetailViewModel: BookDetailViewModel.getMockedViewModel())
        }
    }
}
