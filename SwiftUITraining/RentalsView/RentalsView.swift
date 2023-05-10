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
        LoadingView(isShowing: $rentalsViewModel.loading) {
            NavigationView {
                VStack {
                    BookTableView(books: rentalsViewModel.rentalBooks)
                        .background(Color.lavender.edgesIgnoringSafeArea(.bottom))
                        .navigationTitle("RENTALS")
                        .onAppear {
                            rentalsViewModel.getRentalBooks()
                        }
                    SuggestionView(books: rentalsViewModel.rentalBooks)
                    Spacer()
                }
            }
        }
    }
}

struct RentalsView_Previews: PreviewProvider {
    static var previews: some View {
        RentalsView()
    }
}
