//
//  RentalsView.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 22/02/2021.
//

import SwiftUI

struct RentalsView: View {
    @StateObject var rentalsViewModel = RentalsViewModel()
    
    var body: some View {
        NavigationView {
            BookTableView(books: rentalsViewModel.rentalBooks.map { $0.book })
            VStack {
                SuggestionView(urlLinks: rentalsViewModel.rentalBooks.map { $0.book.image })
                Spacer()
            }
            
            .background(Color.lavender.edgesIgnoringSafeArea(.bottom))
            .navigationTitle("WISHLIST")
            .onAppear {
                rentalsViewModel.getRentalBooks()
            }
        }
    }
    
}

struct RentalsView_Previews: PreviewProvider {
    static var previews: some View {
        RentalsView()
    }
}
