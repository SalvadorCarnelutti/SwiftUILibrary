//
//  HomeView.swift
//  SwiftUITraining
//
//  Created by Diego Quiros on 15/10/2020.
//

import SwiftUI
import Combine

struct HomeView: View {
    // For more about published values:
    /*
     https://levelup.gitconnected.com/state-vs-stateobject-vs-observedobject-vs-environmentobject-in-swiftui-81e2913d63f9
     */
    @StateObject var homeViewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    Color.clear.padding(.bottom, 20)
                    ForEach(homeViewModel.books) { book in
                        BookCellView(book: book)
                            .padding(.bottom, 5)
                    }
                    Color.clear.padding(.bottom, 10)
                }.padding(.horizontal, 20)
            }
            .background(Color.lavender.edgesIgnoringSafeArea(.bottom))
            .navigationTitle("LIBRARY")
            .onAppear() {
                        self.homeViewModel.getBooks()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
        }
    }
}
