//
//  LibraryView.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 15/10/2020.
//

import SwiftUI

struct LibraryView: View {
    /*
     For more about published values:
     https://levelup.gitconnected.com/state-vs-stateobject-vs-observedobject-vs-environmentobject-in-swiftui-81e2913d63f9
     */
    @EnvironmentObject var vm: UserStateViewModel
    @StateObject var libraryViewModel: LibraryViewModel
    @State private var isFirstAppear = true
    
    var body: some View {
        LoadingView(isShowing: $libraryViewModel.isLoading) {
            NavigationView {
                BookTableView(books: libraryViewModel.books, wishlistable: true)
                    .background(Color.lavender.edgesIgnoringSafeArea(.bottom))
                    .navigationTitle("LIBRARY")
                    .toolbar {
                        LogoutButton(buttonAction: vm.signOut)
                    }
                    .onAppear {
                        if isFirstAppear {
                            isFirstAppear = false
                            libraryViewModel.getBooks()
                        }
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let mockViewModel = LibraryViewModel(books: Book.getMockedBooks())
        let vm = UserStateViewModel.getMock(loggedIn: false)
        
        LibraryView(libraryViewModel: mockViewModel)
            .environmentObject(vm)
    }
}
