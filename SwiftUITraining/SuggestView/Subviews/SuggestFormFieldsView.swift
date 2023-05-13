//
//  SuggestFormFieldsView.swift
//  SwiftUITraining
//
//  Created by Salvador on 5/12/23.
//

import SwiftUI

struct SuggestFormFieldsView: View {
    @ObservedObject var suggestViewModel: SuggestViewModel
    
    var body: some View {
        SuggestionTextField(placeholderText: "Book's name",
                            footerText: "Only alphabet characters",
                            fieldBindString: $suggestViewModel.bookName)
        SuggestionTextField(placeholderText: "Author",
                            footerText: "Only alphabet characters",
                            fieldBindString: $suggestViewModel.bookAuthor)
        SuggestionTextField(placeholderText: "Year",
                            footerText: "4 digit year",
                            fieldBindString: $suggestViewModel.bookYear)
    }
}

struct SuggestFormFieldsView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = SuggestViewModel.getMockedSuggestViewModel()
        
        VStack {
            SuggestFormFieldsView(suggestViewModel: SuggestViewModel())
                .padding()
            Spacer()
            SuggestFormFieldsView(suggestViewModel: vm)
                .padding()
        }
    }
}

