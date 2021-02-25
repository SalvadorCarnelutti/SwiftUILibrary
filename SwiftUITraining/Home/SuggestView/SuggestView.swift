//
//  SuggestView.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 19/02/2021.
//

import SwiftUI

struct SuggestView: View {
    @State private var _suggestionResponseIsPresented = false
    @StateObject private var _suggestViewModel = SuggestViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Image("ic_add photo")
                        Spacer()
                    }
                    .padding(.bottom)
                    SuggestionTextField(placeholderText: "Book's name", fieldBindString: $_suggestViewModel.bookName)
                    SuggestionTextField(placeholderText: "Author", fieldBindString: $_suggestViewModel.bookAuthor)
                    SuggestionTextField(placeholderText: "Year", fieldBindString: $_suggestViewModel.bookYear)
                    SuggestionTextField(placeholderText: "Topic", fieldBindString: $_suggestViewModel.bookTopic)
                    SuggestionTextField(placeholderText: "Description", fieldBindString: $_suggestViewModel.bookDescription)
                }
                .padding(20)
                .navigationTitle("SUGGEST BOOK")
                
                Button(action: {
                    _suggestViewModel.postBookSuggestion {
                        _suggestionResponseIsPresented.toggle()
                    }
                }) {
                    Text("SUBMIT").font(.headline)
                }
                .padding(.bottom, 22)
                .disabled(allFieldsFilled)
            }
            .background(Color.white.cornerRadius(5).shadow(radius: 2))
            .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
            .background(Color.lavender)
            .alert(isPresented: $_suggestionResponseIsPresented, content: {
                Alert(title: Text(_suggestViewModel.alertTitle),
                      message: Text(_suggestViewModel.alertMessage),
                      dismissButton: .default(Text("Ok")))
            })
        }
    }
    
    var allFieldsFilled: Bool {
        return
            _suggestViewModel.bookName.isEmpty ||
            _suggestViewModel.bookAuthor.isEmpty ||
            _suggestViewModel.bookYear.isEmpty ||
            _suggestViewModel.bookTopic.isEmpty ||
            _suggestViewModel.bookDescription.isEmpty
    }
}

struct SuggestView_Previews: PreviewProvider {
    static var previews: some View {
        SuggestView()
    }
}