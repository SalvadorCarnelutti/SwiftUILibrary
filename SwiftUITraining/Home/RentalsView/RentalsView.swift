//
//  RentalsView.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 22/02/2021.
//

import SwiftUI

struct RentalsView: View {
    @StateObject private var _rentalsViewModel = RentalsViewModel()
    
    var body: some View {
        NavigationView {
            BookTableView(books: _rentalsViewModel.rentalBooks.map { $0.book })
            VStack {
                SuggestionView(urlLinks: _rentalsViewModel.rentalBooks.map { $0.book.image })
                Spacer()
            }
            
            .background(Color.lavender.edgesIgnoringSafeArea(.bottom))
            .navigationTitle("WISHLIST")
            .onAppear {
                _rentalsViewModel.getRentalBooks()
            }
        }
    }
    
}

struct RentalsView_Previews: PreviewProvider {
    static var previews: some View {
        RentalsView()
    }
}
