//
//  SuggestView.swift
//  SwiftUITraining
//
//  Created by Salvador Carnelutti on 19/02/2021.
//

import SwiftUI

struct SuggestView: View {
    @State private var suggestionResponseIsPresented = false
    @StateObject private var suggestViewModel = SuggestViewModel()
    @EnvironmentObject var vm: UserStateViewModel

    var body: some View {
        LoadingView(isShowing: $suggestViewModel.loading) {
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
                        SuggestionTextField(placeholderText: "Book's name", fieldBindString: $suggestViewModel.bookName)
                        SuggestionTextField(placeholderText: "Author", fieldBindString: $suggestViewModel.bookAuthor)
                        SuggestionTextField(placeholderText: "Year", fieldBindString: $suggestViewModel.bookYear)
                        SuggestionTextField(placeholderText: "Topic", fieldBindString: $suggestViewModel.bookTopic)
                        SuggestionTextField(placeholderText: "Description", fieldBindString: $suggestViewModel.bookDescription)
                    }
                    .padding(20)
                    .navigationTitle("SUGGEST BOOK")
                    
                    Button(action: {
                        // TODO: Present something
//                        suggestViewModel.postBookSuggestion {
//                            suggestionResponseIsPresented.toggle()
//                        }
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
                .alert(isPresented: $suggestionResponseIsPresented, content: {
                    Alert(title: Text(suggestViewModel.alertTitle),
                          message: Text(suggestViewModel.alertMessage),
                          dismissButton: .default(Text("Ok")))
                })
                .toolbar {
                    LogoutButton(buttonAction: vm.signOut)
                }
            }
        }
    }
    
    var allFieldsFilled: Bool {
        return
            suggestViewModel.bookName.isEmpty ||
            suggestViewModel.bookAuthor.isEmpty ||
            suggestViewModel.bookYear.isEmpty ||
            suggestViewModel.bookTopic.isEmpty ||
            suggestViewModel.bookDescription.isEmpty
    }
}

struct SuggestView_Previews: PreviewProvider {
    static var previews: some View {
        SuggestView()
    }
}
