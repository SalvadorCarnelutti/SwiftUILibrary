//
//  LibraryView.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 15/10/2020.
//

import SwiftUI

struct LibraryView: View {
    // For more about published values:
    /*
     https://levelup.gitconnected.com/state-vs-stateobject-vs-observedobject-vs-environmentobject-in-swiftui-81e2913d63f9
     */
    @StateObject var libraryViewModel: LibraryViewModel
    
    var body: some View {
        LoadingView(isShowing: $libraryViewModel.loading) {
            NavigationView {
                BookTableView(books: libraryViewModel.books)
                    .background(Color.lavender.edgesIgnoringSafeArea(.bottom))
                    .navigationTitle("LIBRARY")
                    .onAppear {
                        libraryViewModel.getBooks()
                    }
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        let mockViewModel = LibraryViewModel(books: Book.getMockedBooks())
//        
//        LibraryView(libraryViewModel: mockViewModel)
//    }
//}
