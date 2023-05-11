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
    
    @State private var showSheet = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        ZStack {
                            Rectangle()
                                .fill(Color.babyBlue)
                                .shadow(radius: 1.5)
                            Image(systemName: "plus.circle")
                                .foregroundColor(.white)
                                .font(.system(size: 48.0, weight: .medium))
                            Image(uiImage: suggestViewModel.bookImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.white)
                        }
                        .frame(width: 94, height: 94)
                        .onTapGesture {
                          showSheet = true
                        }

                        Spacer()
                    }
                    .padding(.bottom)
                    SuggestionTextField(placeholderText: "Book's name",
                                        fieldBindString: $suggestViewModel.bookName)
                    SuggestionTextField(placeholderText: "Author",
                                        fieldBindString: $suggestViewModel.bookAuthor)
                    SuggestionTextField(placeholderText: "Year",
                                        fieldBindString: $suggestViewModel.bookYear)
                }
                .padding(20)
                .navigationTitle("SUGGEST BOOK")
                
                // TODO: Present something
                CapsuleButton(buttonTitle: "SUBMIT",
                              enabled: $suggestViewModel.isSubmitEnabled) {
                    suggestionResponseIsPresented = true
                    suggestViewModel.clearForm()
                }
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
            .sheet(isPresented: $showSheet) {
                // Pick an image from the photo library:
                ImagePicker(sourceType: .photoLibrary, selectedImage: $suggestViewModel.bookImage)
            }
        }
    }
}

struct SuggestView_Previews: PreviewProvider {
    static var previews: some View {
        SuggestView()
    }
}
