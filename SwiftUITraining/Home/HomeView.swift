//
//  HomeView.swift
//  SwiftUITraining
//
//  Created by Diego Quiros on 15/10/2020.
//

import SwiftUI

struct HomeView: View {
    // For more about published values:
    /*
     https://levelup.gitconnected.com/state-vs-stateobject-vs-observedobject-vs-environmentobject-in-swiftui-81e2913d63f9
     */
    @StateObject var homeViewModel: HomeViewModel
    
    var body: some View {
        LoadingView(isShowing: $homeViewModel.loading) {
            NavigationView {
                BookTableView(books: homeViewModel.books)
                    .background(Color.lavender.edgesIgnoringSafeArea(.bottom))
                    .navigationTitle("LIBRARY")
                    .onAppear {
                        homeViewModel.loading = true
                        self.homeViewModel.getBooks()
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let mockViewModel = HomeViewModel(books: Book.getMockedBooks())
        
        NavigationView {
            HomeView(homeViewModel: mockViewModel)
        }
    }
}
