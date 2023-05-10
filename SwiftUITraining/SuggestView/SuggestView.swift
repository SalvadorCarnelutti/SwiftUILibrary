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
        LoadingView(isShowing: $_suggestViewModel.loading) {
            NavigationView {
                ScrollView {
                    VStack {
                        HStack {
                            ZStack {
                                Rectangle()
                                    .fill(Color.babyBlue)
                                    .frame(width: 94, height: 94)
                                    .shadow(radius: 1.5)
                                Image(systemName: "plus.circle")
                                    .foregroundColor(.white)
                                    .font(.system(size: 44.0, weight: .medium))
                            }

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
                .padding(20)
                .background(Color.lavender)
                // Maybe it would be nice that if post is successful, all fields are emptied?
                .alert(isPresented: $_suggestionResponseIsPresented, content: {
                    Alert(title: Text(_suggestViewModel.alertTitle),
                          message: Text(_suggestViewModel.alertMessage),
                          dismissButton: .default(Text("Ok")))
                })
            }
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
