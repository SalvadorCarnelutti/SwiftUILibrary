//
//  ContentView.swift
//  SwiftUITraining
//
//  Created by Diego Quiros on 15/10/2020.
//

import SwiftUI
import Foundation

struct HomeView: View {
    let menu = Bundle.main.decode([Book].self, from: "menu.json")
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    Color.clear.padding(.bottom, 20)
                    ForEach(menu) { book in
                        BookCellView(book: book)
                    }
                    Color.clear.padding(.bottom, 10)
                }.padding(.horizontal, 20)
            }.background(Color(hex: 0xEAF6FA).edgesIgnoringSafeArea(.bottom))
            .navigationTitle("Library")
        }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
