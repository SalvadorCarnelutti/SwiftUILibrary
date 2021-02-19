//
//  SuggestView.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 19/02/2021.
//

import SwiftUI

struct SuggestView: View {
    @State private var bookName = ""
    @State private var bookAuthor = ""
    @State private var bookYear = ""
    @State private var bookTopic = ""
    @State private var bookDescription = ""

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Image("ic_add photo")
                        Spacer()
                    }
                    .padding(.bottom)
                    SuggestionTextField(placeholderText: "Book's name", fieldBindString: $bookName)
                    SuggestionTextField(placeholderText: "Author", fieldBindString: $bookAuthor)
                    SuggestionTextField(placeholderText: "Year", fieldBindString: $bookYear)
                    SuggestionTextField(placeholderText: "Topic", fieldBindString: $bookTopic)
                    SuggestionTextField(placeholderText: "Description", fieldBindString: $bookDescription)
                }
                .padding(20)
                .navigationTitle("SUGGEST BOOK")
                
                Button(action: {
                    // TO DO: Post book suggestion request
                }) {
                    Text("SUBMIT").font(.headline)
                }
                .disabled(allFieldsFilled)
            }
            .background(Color.white.cornerRadius(5).shadow(radius: 2))
            .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
            .background(Color.lavender)

        }
    }
    
    var allFieldsFilled: Bool {
        return bookName.isEmpty || bookAuthor.isEmpty || bookYear.isEmpty || bookTopic.isEmpty || bookDescription.isEmpty
    }
}

struct SuggestView_Previews: PreviewProvider {
    static var previews: some View {
        SuggestView()
    }
}
